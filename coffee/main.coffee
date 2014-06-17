manager = null

window.onresize = ->
  manager?.handleResize?()

window.onload = ->
  manager = new window.Manager()
  manager.setup()
  manager.handleResize()
  for element in document.getElementsByTagName 'img'
    element.ondragstart = (e) -> e.preventDefault()
