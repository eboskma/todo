class Todo.Collections.Entries extends Backbone.Collection
	url: '/api/entries'
	model: Todo.Models.Entry

	done: ->
		@filter (todo) ->
			todo.get 'done'

	remaining: ->
		@without(@done())


	clearCompleted: ->
		@done().forEach (todo) ->
			todo.destroy()