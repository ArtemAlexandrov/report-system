import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

state = {
  tasks: []
  newTask: {
    title: null
    description: null
    status: null
    tracker: null
    assignee: null
    errors: {
      title: null
      description: null
      status: null
      tracker: null
      assignee: null
    }
  }
}

mutations = {
  saveTask: (state) ->
    state.tasks.push({
      title: state.newTask.title
      description: state.newTask.description
      status: state.newTask.status
      tracker: state.newTask.tracker
      assignee: state.newTask.assignee
    })
  removeTask: (state, task) -> state.tasks.filter((t) -> t.id isnt task.id)
  clearNewTask: (state) ->
    state.newTask.title       = null
    state.newTask.description = null
    state.newTask.status      = 'new'
    state.newTask.tracker     = 'feature'
    state.newTask.assignee    = null
    state.newTask.errors.title       = null
    state.newTask.errors.description = null
    state.newTask.errors.status      = null
    state.newTask.errors.tracker     = null
    state.newTask.errors.assignee    = null
}

actions = {
  saveTask: (options) ->
    options.commit('saveTask')
    options.commit('clearNewTask')
  removeTask: (options) ->
    options.commit('removeTask', task)
  taskClass: (task) ->
    switch task.tracker
      when 'bug' then 'is-warning'
      when 'feature' then 'is-primary'
      when 'reopen' then 'is-danger'
}

getters = {
  bugs:      -> state.tasks.filter((task) -> task.tracker is 'bug')
  features:  -> state.tasks.filter((task) -> task.tracker is 'feature')
  improves:  -> state.tasks.filter((task) -> task.tracker is 'improve')
  supports:  -> state.tasks.filter((task) -> task.tracker is 'support')
  estimates: -> state.tasks.filter((task) -> task.tracker is 'estimate')
}

export default new Vuex.Store({
  state: state
  getters: getters
  actions: actions
  mutations: mutations
})