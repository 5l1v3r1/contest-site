{FlipAnimation} = window

addClass = (div, aClass) ->
  names = (div.className ? '').split ' '
  return if aClass in names
  names.push aClass
  div.className = names.join ' '

removeClass = (div, aClass) ->
  names = (div.className ? '').split ' '
  return if not aClass in names
  names.splice names.indexOf(aClass), 1
  div.className = names.join ' '

class Manager
  constructor: ->
    @numFlipped = null
    @container = document.getElementById 'container'
    @challenges = [
      document.getElementById 'challenge1'
      document.getElementById 'challenge2'
      document.getElementById 'challenge3'
      document.getElementById 'challenge4'
    ]
    @submit = document.getElementById 'submit'
    @leaderboard = document.getElementById 'leaderboard'
    @description = document.getElementById 'description'

  setup: ->
    for challenge, i in @challenges
      do (i) => challenge.onclick = => @itemClicked i

  getContentRect: ->
    contentRect =
      width: Math.min 1100, Math.max 700, window.innerWidth - 20
      height: Math.min 700, Math.max 600, window.innerHeight - 20
    contentRect.x = (window.innerWidth - contentRect.width) / 2
    contentRect.y = (window.innerHeight - contentRect.height) / 2
    return contentRect

  handleResize: ->
    rect = @getContentRect()
    cellWidth = (Math.ceil rect.width / 2) - 10
    cellHeight = (Math.ceil rect.height / 2) - 10
    minSize = Math.min cellWidth, cellHeight
    imageSize = Math.min minSize - 100, 200
    for image in document.getElementsByClassName 'challenge-image'
      image.style.width = imageSize + 'px'
      image.style.height = imageSize + 'px'
      image.style.left = ((cellWidth - imageSize) / 2) + 'px'
      image.style.top = ((cellHeight - imageSize) / 2) + 'px'
    for challenge, i in @challenges
      x = rect.x + ((i % 2) * (cellWidth + 20))
      y = rect.y + (if i < 2 then 0 else cellHeight + 20)
      challenge.style.width = cellWidth + 'px'
      challenge.style.height = cellHeight + 'px'
      challenge.style.left = x + 'px'
      challenge.style.top = y + 'px'

  itemClicked: (number) ->
    return if FlipAnimation.isAnimating()
    if @numFlipped?
      return if @numFlipped isnt number
      [start, end] = [180, 0]
      removeClass @challenges[number], 'challenge-selected'
    else
      [start, end] = [0, 180]
      @moveDivs number
      addClass @challenges[number], 'challenge-selected'
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
    divs = [@description, @submit, @leaderboard]
    index = 0
    for challenge, i in @challenges
      continue if i is idx
      x = divs[index++]
      x.parentElement.removeChild x if x.parentElement?
      x.style.display = 'block'
      challenge.getElementsByClassName('back')[0].appendChild x


window.Manager = Manager
