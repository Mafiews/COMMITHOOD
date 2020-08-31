class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @events = Event.all.first(3)
  end

  def dashboard
    @my_events = current_user.events.sort_by { |event| event.start_date }
    # Kally : set variables to filter @my_events
    @my_upcoming_events = []
    @my_past_events = []
    @my_events.each do |my_event|
      if my_event.end_date < Date.today
        @my_past_events << my_event
      else
        @my_upcoming_events << my_event
      end
    end
    @my_upcoming_events
    @my_past_events

    @events_liked = current_user.find_liked_items
  end
end
