{FlipAnimation} = window

class DesktopManager extends window.Manager
  constructor: ->
    super()
    @numFlipped = null
  
  setup: ->
    @container.className = 'container-desktop'
    for challenge, i in @challenges
      do (i) => challenge.onclick = => @itemClicked i
  
  handleResize: ->
    cellWidth = window.innerWidth / 2
    cellHeight = window.innerHeight / 2
    minSize = Math.min(cellWidth, cellHeight)
    imageSize = Math.min minSize - 100, 200
    textSize = Math.min (cellHeight - imageSize) / 2, cellWidth / 15, 30
    for image in document.getElementsByClassName 'challenge-image'
      image.style.width = imageSize + 'px'
      image.style.height = imageSize + 'px'
      image.style.left = ((cellWidth - imageSize) / 2) + 'px'
      image.style.top = ((cellHeight - imageSize) / 2) + 'px'
    for label in document.getElementsByClassName 'challenge-title'
      label.style['font-size'] = textSize + 'px'
      label.style.top = (cellHeight - textSize - 10) + 'px'

  itemClicked: (number) ->
    return if FlipAnimation.isAnimating()
    if @numFlipped?
      return if @numFlipped isnt number
      [start, end] = [180, 0]
    else
      [start, end] = [0, 180]
      @moveDivs number
    delay = 0
    for challenge, i in @challenges
      continue if i is number
      new FlipAnimation(challenge, start, end, 0.8).start delay
      delay += 200
    if @numFlipped?
      @numFlipped = null
    else 
      @numFlipped = number
  
  moveDivs: (idx) ->
    divs = [@submit, @scoreboard, @description]
    index = 0
    for challenge, i in @challenges
      continue if i is idx
      x = divs[index++]
      x.parentElement.removeChild x if x.parentElement?
      x.style.display = 'block'
      challenge.getElementsByClassName('back')[0].appendChild x

window.DesktopManager = DesktopManager
