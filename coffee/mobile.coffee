window.isMobileBrowser = ->
  # clearly, this could be done way better
  return window.innerWidth < 300 || window.innerHeight < 400

{FlipAnimation} = window

class MobileManager extends window.Manager
  constructor: -> super()
  setup: -> @container.className = 'container-mobile'
  handleResize: ->

window.MobileManager = MobileManager
