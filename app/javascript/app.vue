<template>
  <div>
    <div class="section">
      <nav class="level">
        <div class="level-item has-text-centered">
          <div>
            <p class="heading">New</p>
            <p class="title">{{ $store.state.tasks.filter(task => task.status === 'new').length }}</p>
          </div>
        </div>
        <div class="level-item has-text-centered">
          <div>
            <p class="heading">Cancelled</p>
            <p class="title">{{ $store.state.tasks.filter(task => task.status === 'cancelled').length }}</p>
          </div>
        </div>
      </nav>

      <div class="columns">
        <div class="column">
          <div class="tile is-ancestor is-vertical">
            <draggable v-model="$store.state.tasks">
                <article class="message"
                         v-for="task in $store.state.tasks"
                         :class="taskClass(task)"
                         v-if="task.status === 'new'"
                         :key="task.id">
                  <div class="message-header">
                    <span class="is-size-5 has-text-weight-semibold">
                      {{ task.title }}
                    </span>
                    <span class="has-text-right">
                      by {{ task.author }} {{ task.created_at }}
                    </span>
                  </div>
                  <div class="message-body" v-html="task.description"></div>
                </article>
            </draggable>
          </div>
        </div>
        <div class="column">
          <div class="tile is-ancestor is-vertical">
            <draggable v-model="$store.state.tasks">
              <transition-group>
                <article class="message"
                         v-for="task in $store.state.tasks"
                         v-if="task.status === 'cancelled'"
                         :key="task.id">
                  <div class="message-header">
                    <span class="is-size-5 has-text-weight-semibold">
                      {{ task.title }}
                    </span>
                    <span class="has-text-right">
                      by {{ task.author }} {{ task.created_at }}
                    </span>
                  </div>
                  <div class="message-body" v-html="task.description"></div>
                </article>
              </transition-group>
            </draggable>
          </div>
        </div>
      </div>
    </div>

    <div class="section">
      <div class="field">
        <label class="label">Title</label>
        <div class="control has-icons-left has-icons-right">
          <input class="input is-danger"
                 type="text"
                 v-model="$store.state.newTask.title"
                 placeholder="Email input">
          <span class="icon is-small is-left">
            <i class="fa fa-envelope"></i>
          </span>
          <span class="icon is-small is-right">
            <i class="fa fa-warning"></i>
          </span>
        </div>
        <p class="help is-danger">This email is invalid</p>
      </div>
      <div class="field">
        <label class="label">Message</label>
        <div class="control">
          <textarea class="textarea"
                    v-model="$store.state.newTask.description"
                    placeholder="Textarea"></textarea>
        </div>
      </div>
      <div class="field is-grouped">
        <div class="control">
          <button class="button is-link" @click="saveTask">Submit</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
  import draggable from 'vuedraggable'
  import store from 'storages/tasks'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    store: store
    components:
      draggable: draggable
    methods: mapActions(['saveTask', 'taskClass']),
  }
</script>