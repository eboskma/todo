window.Todo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Todo.Routers.Entries
    Backbone.history.start()

jQuery ->
  Todo.init()
