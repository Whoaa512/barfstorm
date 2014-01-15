# $ = require 'jquery'
# _ = require 'lodash'

p1Cards = []
p2Cards = []
$container = $ '#container'

randomName = ->
  _.sample [
    'kia'
    'doug'
    'cj'
    'bill'
    'anitra'
    'eric'
    'kyle'
    'brian'
  ]

randomAdj = ->
  _.sample [
    'terrifying'
    'humongous'
    'puny'
    'ridiculous'
    'average'
  ]

randomTitle = ->
  _.sample [
    'babooshka'
    'jester'
    'chicken tosser'
    'troll'
    'single white man'
  ]

class Card
  constructor: (@title, @attack, @health, @owner) ->
    @$el = $ "<div class='card #{@owner}'>"
  render: ->
    @$el.html [
      "<span class='title'>#{@title}</span>"
      "<span class='attack'>a: #{@attack}</span>"
      "<span class='health'>h: #{@health}</span>"
    ]
    $("##{@owner}Arena").append @$el


createRandomCard = (owner) ->
  attack = ~~(Math.random() * 3) + 1
  health = ~~(Math.random() * 3)  + 1
  adj = randomAdj()
  if adj in ['terrifying', 'humongous'] then attack = 4
  new Card "#{randomName()} the #{adj} #{randomTitle()}",attack,health,owner


_.times 5, ->
  p1Cards.push createRandomCard 'p1'
  p2Cards.push createRandomCard 'p2'




_.forEach p1Cards, (item, key, list) ->
  # console.log arguments
  item.render()

_.forEach p2Cards, (item, key, list) ->
  # console.log arguments
  item.render()

# @todo: make the rest of the game engine
# turn = ->
#   _.