class Todo.Views.Entry extends Backbone.View
	template: JST['entries/entry']
	tagName: 'li'

	events:
		'click .check': 'toggleDone'
		'dblclick div.todo-text': 'edit'
		'click span.todo-destroy': 'clear'
		'keypress .todo-input': 'updateOnEnter'
		'blur .todo-input': 'close'

	initialize: ->
		@model.on('change', @render, this)
		@model.on('destroy', @remove, this)
		console.log JSON.stringify(@model, null, 2)

	render: ->
		@$el.html(@template(entry: @model))
		@input = @$('.todo-input')
		@input.val(@model.get('text'))
		this

	toggleDone: ->
		@model.toggle()

	edit: ->
		@$el.addClass 'editing'
		@input.focus()

	clear: ->
		@model.destroy()

	remove: ->
		@$el.remove()

	close: =>
		@model.save text: @input.val(),
			wait: true
			success: => @$el.removeClass 'editing'
			error: @handleError

	handleError: (entry, response) ->
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				alert "#{attribute} #{message}" for message in messages
		

	updateOnEnter: (event) ->
		if event.keyCode is 13
			@close()