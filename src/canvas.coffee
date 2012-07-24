class Canvas
	###
	Ver.1.0.2
	###
	width: 0
	height: 0
	frameRate: 30
	fillColor:'rgba(0, 0, 0, 1)'
	strokeColor:'rgba(0, 0, 0, 1)'
	backgroundColor:'rgb(255, 255, 255)'
	mouseX:0
	mouseY:0
	cv: null
	cx: null
	_isResize: true
	_timer: null

	constructor: (canvasID, width, height, isResize = true)->
		@cv = document.getElementById(canvasID)
		@cx = @cv.getContext("2d")
		@_isResize = isResize
		if isResize
			if window.addEventListener
				window.addEventListener("resize", @resize)
			else 
				window.attachEvent("onresize", @resize)
		@resize(width, height)

		if window.addEventListener
			@cv.addEventListener("mousemove", @getMousePos)
		else 
			@cv.attachEvent("onmousemove", @getMousePos)
		@setup()

	setup: ->

	main: =>
		@.update()
		@.draw()

	update: ->

	draw: ->

	resize: (w, h)=>
		if not isNaN(w)
			@width = w
		else 
			if @_isResize
				@width = @windowWidth()

		if not isNaN(h)
			@height = h
		else 
			if @_isResize
				@height = @windowHeight()

		@cv.width = @width
		@cv.height = @height

	play: ->
		@_timer = setInterval @main, 1000 / @frameRate

	stop: ->
		clearInterval @_timer

	windowWidth: ->
		size = 0
		
		if document.documentElement.clientWidth
			size = document.documentElement.clientWidth
		else
			if document.body.clientWidth
				size = document.body.clientWidth
			else 
				if window.innerWidth
					size = window.innerWidth
		size

	windowHeight: ->
		size = 0
    
		if document.documentElement.clientHeight
			size = document.documentElement.clientHeight
		else
			if document.body.clientHeight
				size = document.body.clientHeight
			else
				if window.innerHeight
					size = window.innerHeight     
		size

	getCanvas: (id)->
		canvasObj = document.getElementById id
		if not canvasObj?
			canvasObj = document.createElement "canvas"
			canvasObj.setAttribute "id", id;
			document.body.appendChild canvasObj
		canvasObj

	getMousePos: (e)=>
		if e.target?
			rect = e.target.getBoundingClientRect()
			@mouseX = e.clientX - rect.left
			@mouseY = e.clientY - rect.top
		else
			@mouseX = e.offsetX
			@mouseY = e.offsetX
		

	#----------------------------------------------------
	@isSupport = ->
		elem = document.createElement 'canvas'
		!!(elem.getContext and elem.getContext('2d'))

	@isSupportText = ->
		if Canvas.isSupport()
			elem = document.createElement 'canvas'
			return !!(elem.getContext("2d").fillText)
		false

	@isSupportWebGL = ->
		!!(window.WebGLRenderingContext)

	#----------------------------------------------------
	line: (startX, startY, endX, endY)->
		@cx.beginPath()
		@cx.strokeStyle = @strokeColor
		@cx.moveTo(startX, startY)
		@cx.lineTo(endX, endY)
		@cx.stroke()

	circle: (x, y, radius)->
		if radius < 0
			radius *= -1
		@cx.beginPath()
		@cx.fillStyle = @fillColor
		@cx.arc(x, y, radius, 0, Math.PI*2, false)
		@cx.fill()

	rect: (x, y, width, height, isCenter = false)->
		if not width?
			width = 1
		if not height?
			height = width
		if isCenter
			x -= width*0.5
			y -= height*0.5
		@cx.fillStyle = @fillColor
		@cx.fillRect(x, y, width, height)

	background: (color)->
		if not color?
			color = @backgroundColor
		@cx.fillStyle = color
		@cx.fillRect(0, 0, @width, @height)

	image: (img, x, y, w, h)->
		@cx.drawImage(img, x, y, w, h)


@.Canvas = Canvas