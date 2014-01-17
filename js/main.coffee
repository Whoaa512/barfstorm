# $ = require 'jquery'
# _ = require 'lodash'
console.log Date.now()

randomName = do ->
  name = _.shuffle [
    'Abraham'
    'Seymore'
    'Isadore'
    'Guy'
    'Anitra'
    'Eric'
    'Yorick'
    'Hammurabi'
    'Ugdor'
    'Olaf'
  ]
  -> name.pop()

randomAdj = do ->
  adj = _.shuffle [
    'Terrifying'
    'Humongous'
    'Puny'
    'Ridiculous'
    'Average'
    'Inflated'
    'Over-Confident'
    'Pompous'
    'Irritating'
    'Flatulent'
  ]
  -> adj.pop()

randomTitle = do ->
  title = _.shuffle [
    'Babooshka'
    'Jester'
    'Chicken Tosser'
    'Troll'
    'Single White Man'
    'Lay-About'
    'Zealot'
    'Windbag'
    'Huffalump'
    'Weasel'
  ]
  -> title.pop()

board =
  $container: $('#container')

class SpellCaster
  constructor: (@$el) ->
    @$el ||= $('div')
    @$el.appendTo board.$container
    @hand = new Hand(@)

class Enemy extends SpellCaster
  turn: ->

class Player extends SpellCaster
  turn: ->
    # _.filter @hand.cards, (c,i) ->
    #     console.log(c)
    #     return c.health > 0
    #   .forEach (c,i)->
    #     setTimeout (-> c.attack(game.enemy)) , 1500 * i
  
class Hand
  constructor: (@owner) ->
    @cards = []
    _.times 5, (i) =>
      @cards.push(Card.createRandom @owner, i)
      @render() 
  render: () ->
    _.forEach @cards, (c, i)->
      c.render()

class Card
  constructor: (@title, @damage, @health, @owner, @index) ->
    @alive = true
    wrapper = $('<div class="card-container">').appendTo @owner.$el
    @$el = $("<div class='card'>").appendTo wrapper
    @$el.on 'click', ()=>
      @attack()
  attack: ()->
    target = game.enemy.hand.cards[@index]
    if target.alive
      @$el.effect('shake', direction: 'down', distance: 100, duration: 200)
      target.takeDamage(@damage, @damage_type)
  render: ->
    @$el.html([
      "<span class='title'>#{@title}</span>"
      "<span class='damage'>a: #{@damage}</span>"
      "<span class='health'>h: #{@health}</span>"
    ])
  takeDamage: (d)->
    @health-= d
    if @health <= 0
      @alive = false
      @$el.effect 'highlight', color: 'red', complete: => @$el.effect('explode')
    else
      @$el.effect('highlight', color: 'red' , complete: => @render() )

Card.createRandom = (owner, i) ->
  damage = ~~(Math.random() * 3) + 2
  health = ~~(Math.random() * 3) + 2
  adj = randomAdj()
  title = randomTitle()
  if adj in ['Terrifying', 'Humongous'] then damage = 5
  if adj in ['Ridiculous', 'Puny'] then damage = 1 
  if title in ['Troll', 'Huffalump'] then health = 5
  if title in ['Babooshka', 'Lay-About'] then health = 1

  new Card "#{randomName()} the #{adj} #{title}", damage, health, owner, i

class Game
  constructor: () ->
    @player = new Player( $('#player-arena') )
    @enemy = new Enemy($('#enemy-arena'))
    @player.turn()
    @enemy.turn()

game = new Game
