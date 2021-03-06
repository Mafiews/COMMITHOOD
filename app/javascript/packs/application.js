// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports

import "bootstrap";


// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

// import mapbox
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initSweetalert } from '../plugins/init_sweetalert';
import { sweetAlertEverywhere } from '../plugins/init_sweetalert';
import { initSelect2 } from '../plugins/init_select2';
import { initUpdateNavbarOnScroll } from '../components/navbar';
import { initEventinfo} from '../plugins/init_eventinfo';
import { initSearchbarIndex } from '../components/init_searchbar_index';
// import { initSlick} from '../plugins/init_slick';
import { initBookmark} from '../components/init_bookmark';
import {initSearchbarIndexHide} from '../components/init_searchbar_index_hide';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initAutocomplete();
  initUpdateNavbarOnScroll();
  initBookmark();
  initSelect2();
  initSearchbarIndex();
  initMapbox();
  initEventinfo();
  initSearchbarIndexHide();
  // initSlick();
 sweetAlertEverywhere();



});


//sweetalert function to display fancy alerts   // Matt



// example from lecture to delete a flat
// import { initSweetalert } from '../plugins/init_sweetalert';
// initSweetalert('#sweet-alert-demo', {
//   title: "Are you sure?",
//   text: "This action cannot be reversed",
//   icon: "warning"
// }, (value) => {
//   if (value) {
//     const link = document.querySelector('#delete-link');
//     link.click();
//   }
// });

// base method from lecture with no callback nor value
// initSweetalert('#sweet-alert-demo', {
//   title: "A nice alert",
//   text: "This is a great alert, isn't it?",
//   icon: "success"
// });
