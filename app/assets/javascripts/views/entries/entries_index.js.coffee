class Todo.Views.EntriesIndex extends Backbone.View

	template: JST['entries/index']

	events:
		'submit #create-todo': 'createEntry'
		'click .todo-clear a': 'clearCompleted'

	initialize: ->
		@collection.on('reset', @render, this)
		@collection.on('add', @appendEntry, this)
		@collection.on('change add remove', @renderStats, this)

	render: ->
		@$el.html(@template())
		@collection.each(@appendEntry)
		@renderStats()
		this

	renderStats: ->
		statsView = new Todo.Views.Stats(
			total: @collection.length
			done: @collection.done().length
			remaining: @collection.remaining().length
		)
		statsRender = statsView.render()
		$('#todo-stats').html(statsRender.el)

	appendEntry: (entry) ->
		view = new Todo.Views.Entry(model: entry)
		$('#todo-list').append(view.render().el)

	createEntry: (event) ->
		event.preventDefault()
		attributes = text: $('#new-todo').val()
		@collection.create attributes,
			wait:true
			success: -> $('#create-todo').get(0).reset()
			error: @handleError

	clearCompleted: ->
		@collection.clearCompleted()

	handleError: (entry, response) ->
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				alert "#{attribute} #{message}" for message in messages
