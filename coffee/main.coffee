manager = null
mobileManager = null
desktopManager = null

window.onresize = ->
  if window.isMobileBrowser() and manager isnt mobileManager
    manager = mobileManager
    manager.setup()
  else if manager isnt desktopManager
    manager = desktopManager
    manager.setup()
  manager.handleResize()

window.onload = ->
  mobileManager = new window.MobileManager()
  desktopManager = new window.DesktopManager()
  window.onresize()
