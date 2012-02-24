class Todo.Models.Entry extends Backbone.Model
	toggle: ->
		@save done: !@get('done')