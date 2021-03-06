class EventsController < ApplicationController
  respond_to :html
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show, :destroy]

  # yizhu: add index controler to show all events
  def index

    @address = params[:address]
    @causes = params.select{|k,v| k.include?('user_cause')}.values

    if @causes.size > 0;
      @causes
    elsif params[:user_cause].present?
      @causes = params[:user_cause]
    else
      @causes = "Tous les thèmes"
    end

    # select_events = policy_scope(Event).geocoded.where(:start_date >= Time.now)

    if !@causes.nil? && (!@causes.include?("Tous les thèmes")) && (params[:address].present?)
      @events = policy_scope(Event).geocoded.near(@address, 8).tagged_with(@causes, any: true)

    elsif !@causes.nil? && (!@causes.include?("Tous les thèmes"))
      @events = policy_scope(Event).geocoded.tagged_with(@causes, any: true)

    elsif params[:address].present?
      @events = policy_scope(Event).geocoded.near(@address, 8)

    else
      @events = policy_scope(Event).geocoded.order(start_date: :desc)
    end

    # Kally
    @participations = Participation.all
    seats_left # private method below to count seats_left
    # fr_datetime

    @markers = @events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        title: event.tag_list,
        image_url: helpers.asset_url(
          case event.tag_list.first
          when "Environnement"
            "tag-environment.png"
          when "Bien-être animal"
            "tag-animal.png"
          when "Culture"
            "tag-culture.png"
          when "Formation"
            "tag-formation.png"
          when "Isolement"
            "tag-isolement.png"
          when "Jeunesse"
            "tag-jeunesse.png"
          when "Personnes âgées"
            "tag-personnes-agees.png"
          when "Précarité"
            "tag-precarite.png"
          when "Santé"
            "tag-sante.png"
          when "Sport"
            "tag-sport.png"
          else
            "logo.png"
          end
          ),
        data_event_id: event.id
        # infoWindow: render_to_string(partial: "info_window", locals: { event: event })
      }
    end

    unless params[:address].nil? || params[:address] == ''
      location = Geocoder.search(params[:address])
      @lat = location[0].latitude
      @lng = location[0].longitude
      @marker = {
        lat: @lat,
        lng: @lng,
        image_url: helpers.asset_url('marqueur-rond-bordure.png')
      }
      @markers << @marker
    end
  end

  # Ilana
  def show
    @participation = Participation.new
  end

  def like
    set_event
    @event.liked_by current_user
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def unlike
    set_event
    @event.unliked_by current_user
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def like_home
    set_event
    @event.liked_by current_user
    redirect_to root_path(anchor: "event-home-#{@event.id}")
  end

  def unlike_home
    set_event
    @event.unliked_by current_user
    redirect_to root_path(anchor: "event-home-#{@event.id}")
  end

  def like_dashboard
    set_event
    @event.liked_by current_user
    redirect_to dashboard_path(anchor: "event-#{@event.id}")
  end

  def unlike_dashboard
    set_event
    @event.unliked_by current_user
    redirect_to dashboard_path(anchor: "event-#{@event.id}")
  end

  private

  # ilana
  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  #Yizhu

  # def filter_events_cause(events, causes)
  #   filter_events = []
  #     causes.each do |cause|
  #       @events.where(causes: cause)
  #     end
  #   filtered_events
  # end

  # Kally
  def seats_left
    @events.each do |event|
      if Participation.where(event_id: event.id)
        event_participations = Participation.where(event_id: event.id)
        event.seats_left = event.seats - event_participations.size
      else
        event.seats_left = event.seats
      end
      event.save
    end
  end

end
