class Canvas1 extends Canvas
	#---------------------------------------------------
	setup: ->
		@fillColor = "#202020"
		@strokeColor = 'rgba(0, 0, 0, 0.1)'
		@backgroundColor = 'rgb(240, 240, 240)'
		@play()
		@pi = Math.PI * 2
		@pointMin = 5
		@pointMax = 60
		@Num = 0

	update: ->
		pointNum = (@mouseX / @width * @pointMax + @pointMin)
		@Num += (pointNum - @Num) * 0.1

	draw: ->
		@background()
		points = @getPoints()

		l = points.length
		i = 0
		while i < l
			j = i + 1
			while j < l
				@line points[i][0], points[i][1], points[j][0], points[j][1]
				j++
			i++

	getPoints: ->
		centerX = @width * 0.5;
		centerY = @height * 0.5;
		radius = @width
		if @width > @height
			radius = @height
		radius *= 0.4
		pointNum = @Num >> 0
		if pointNum < @pointMin
			pointNum = @pointMin
		if pointNum > @pointMax
			pointNum = @pointMax
		step = @pi / pointNum
		theta = step * 0.5
		points = new Array(pointNum)
		i = 0
		while i < pointNum
			xp = centerX + radius * Math.cos(theta);
			yp = centerY + radius * Math.sin(theta);
			points[i] = [xp, yp]
			theta += step
			i++
		points


@.Canvas1 = Canvas1