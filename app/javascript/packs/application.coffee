import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue'
import App from '../app.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener 'turbolinks:load', =>
  container = document.getElementById('hello')
  new Vue(App).$mount container
