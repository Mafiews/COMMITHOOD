import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    width: '100%',
    placeholder: "Choisissez un ou plusieurs thèmes",
    allowClear: true
  });
};


const initSelect2Multi = () => {
  $('.select2').select2({
    width: '100%',
    placeholder: "Choisissez un ou plusieurs thèmes",
    allowClear: true
  });
};

export { initSelect2 };
