class Todo.Views.Stats extends Backbone.View
	template: JST['entries/stats']
	
	render: ->
		@$el.html(@template(
			total: @options.total
			done: @options.done
			remaining: @options.remaining
		))
		this