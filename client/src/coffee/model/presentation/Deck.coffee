###
@author Matt Crinklaw-Vogt
###
define(["common/Calcium", "./SlideCollection",
		"./Slide",
		"model/common_application/UndoHistory"],
(Backbone, SlideCollection, Slide, UndoHistory) ->
	NewSlideAction = (deck) ->
		@deck = deck
		@

	NewSlideAction.prototype =
		do: () ->
			slides = @deck.get("slides")
			if not @slide?
				@slide = new Slide({num: slides.length})
			slides.add(@slide)
			@slide

		undo: () ->
			@deck.get("slides").remove(@slide)

		name: "Create Slide"

	RemoveSlideAction = (deck, slide) ->
		@deck = deck
		@slide = slide
		@

	RemoveSlideAction.prototype =
		do: () ->
			slides = @deck.get("slides")
			slides.remove(@slide)
			@slide

		undo: () ->
			@deck.get("slides").add(@slide)

		name: "Remove Slide"


	Backbone.Model.extend(
		initialize: () ->
			@undoHistory = new UndoHistory(20)
			@set("slides", new SlideCollection())
			slides = @get("slides")
			slides.on("add", @_slideAdded, @)
			slides.on("remove", @_slideRemoved, @)
			
		newSlide: () ->
			action = new NewSlideAction(@)
			slide = action.do()
			@undoHistory.push(action)
			slide

		set: (key, value) ->
			if key is "activeSlide"
				@_activeSlideChanging(value)
			Backbone.Model.prototype.set.apply(this, arguments)

		import: (rawObj) ->
			slides = @get("slides")
			slides.each((slide) ->
				slides.remove(slide)
			)
			@set("activeSlide", null)

			rawObj.slides.forEach((slide) ->
				slides.add(slide)
			)

			console.log "Importing"

		_activeSlideChanging: (newActive) ->
			lastActive = @get("activeSlide")
			if lastActive?
				lastActive.unselectComponents()
		
		_slideAdded: (slide, collection) ->
			@set("activeSlide", slide)

		_slideRemoved: (slide, collection, options) ->
			console.log "Slide removed"
			if @get("activeSlide") is slide
				if options.index < collection.length
					@set("activeSlide", collection.at(options.index))
				else if options.index > 0
					@set("activeSlide", collection.at(options.index - 1))
				else
					@set("activeSlide", null)

		removeSlide: (slide) ->
			action = new RemoveSlideAction(@, slide)
			slide = action.do()
			@undoHistory.push(action)
			slide

		undo: () ->
			@undoHistory.undo()

		redo: () ->
			@undoHistory.redo()
	)
)