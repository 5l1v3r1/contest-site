setGeneral = (div, attribute, value) ->
  for prefix in ['', '-webkit-', '-ms-']
    if value?
      div.style[prefix + attribute] = value
    else
      div.style[prefix + attribute] = ''

class FlipAnimation
  @animationList: []
  @frameDuration: 0.01666666667
  
  @isAnimating: -> @animationList.length 
  
  constructor: (@div, @sourceAngle, @destAngle, @duration) ->
    @elapsed = 0
    @theTimeout = null
  
  cancel: ->
    if @theTimeout?
      clearTimeout @theTimeout
      @theTimeout = null
    @elapsed = 0
  
  start: (initDelay = 0) ->
    @cancel()
    FlipAnimation.animationList.push this
    @theTimeout = setTimeout @_initialize.bind(@), initDelay
  
  _didEnd: ->
    frontDiv = @div.getElementsByClassName('front')[0]
    backDiv = @div.getElementsByClassName('back')[0]
    if @destAngle > 90
      # flipped to the back side
      frontDiv.style.display = 'none'
    else
      # flipped to the front side
      backDiv.style.display = 'none'
    setGeneral frontDiv, 'transform', null
    setGeneral backDiv, 'transform', null
    setGeneral @div, 'transform', null
    list = FlipAnimation.animationList
    list.splice list.indexOf @
  
  _tick: (x = true) ->
    @theTimeout = null
    
    percentage = Math.min(@elapsed, @duration) / @duration
    angle = @sourceAngle + (@destAngle - @sourceAngle) * percentage
    setGeneral @div, 'transform', 'rotateY(' + angle + 'deg)'
    
    if @elapsed < @duration
      @elapsed += FlipAnimation.frameDuration
      msCount = FlipAnimation.frameDuration * 1000
      @theTimeout = setTimeout @_tick.bind(@), msCount
    else if x
      @_didEnd()
  
  _initialize: ->
    backDiv = @div.getElementsByClassName('back')[0]
    setGeneral backDiv, 'transform', 'rotateY(180deg)'
    if @destAngle < 90
      frontDiv = @div.getElementsByClassName('front')[0]
      frontDiv.style.display = 'block'
    else
      backDiv.style.display = 'block'
    @_tick()


window.FlipAnimation = FlipAnimation
