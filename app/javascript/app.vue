<template>
  <div>
    <div class="section">
      <nav class="level">
        <div class="level-item has-text-centered">
          <div>
            <p class="heading">New</p>
            <p class="title">{{ tasks.filter(task => task.status === 'new').length }}</p>
          </div>
        </div>
        <div class="level-item has-text-centered">
          <div>
            <p class="heading">Cancelled</p>
            <p class="title">{{ tasks.filter(task => task.status === 'cancelled').length }}</p>
          </div>
        </div>
      </nav>

      <div class="columns">
        <div class="column">
          <div class="tile is-ancestor is-vertical">
            <draggable v-model="tasks">
              <transition-group>
                <article class="message"
                         v-for="task in tasks"
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
              </transition-group>
            </draggable>
          </div>
        </div>
        <div class="column">
          <div class="tile is-ancestor is-vertical">
            <draggable v-model="tasks">
              <transition-group>
                <article class="message"
                         v-for="task in tasks"
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
                 v-model="newTask.title"
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
                    v-model="newTask.description"
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

  export default {
    components:
      draggable: draggable
    data: ->
      {
        message: 'Hello!'
        tasks: [
          {
            id: 0
            title: 'Форма для сохранения задач в базу данных'
            description: 'Bla bla'
            status: 'new'
            tracker: 'bug'
            author: 'Artem'
            assignee: 'Me'
            created_at: '1 day from now'
            order: 0
          }
          {
            id: 1
            title: 'Форма для сохранения задач в базу данных'
            description: 'Bla bla'
            status: 'cancelled'
            tracker: 'bug'
            author: 'Artem'
            assignee: 'Me'
            created_at: '2 day from now'
            order: 1
          }
        ]
        newTask: {
          id: null
          title: null
          description: null
          status: null
          tracker: null
          author: null
          assignee: null
          created_at: null
        }
      }
    methods:
      taskClass: (task) ->
        switch task.tracker
          when 'bug' then 'is-warning'
          when 'feature' then 'is-primary'
          when 'reopen' then 'is-danger'
      saveTask: ->
        this.tasks.push
          id: this.tasks.length + 1
          title: this.newTask.title
          description: this.newTask.description
          author: 'Me'
          status: 'new'
          created_at: 'just now'
          order: this.tasks.length + 1
        this.newTask.title = null
        this.newTask.description = null
  }
</script>