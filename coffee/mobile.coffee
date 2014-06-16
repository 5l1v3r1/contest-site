window.isMobileBrowser = ->
  # clearly, this could be done way better
  return window.innerWidth < 300 || window.innerHeight < 400
