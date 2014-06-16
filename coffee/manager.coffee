class Manager
  constructor: ->
    @container = document.getElementById 'container'
    @challenges = [
      document.getElementById 'challenge1'
      document.getElementById 'challenge2'
      document.getElementById 'challenge3'
      document.getElementById 'challenge4'
    ]
    @submit = document.getElementById 'submit'
    @scoreboard = document.getElementById 'scoreboard'
    @description = document.getElementById 'description'

window.Manager = Manager
