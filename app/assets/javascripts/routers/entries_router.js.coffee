class Todo.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'

  initialize: ->
    @collection = new Todo.Collections.Entries()
    @collection.fetch()

  index: ->
    view = new Todo.Views.EntriesIndex(collection: @collection)
    $('#todoapp').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}"
