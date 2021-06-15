# frozen_string_literal: true

require 'colorize'
require 'byebug'
require_relative 'interface'
require_relative 'game_rules'
require_relative 'bank'
require_relative 'printer'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'user'
require_relative 'dealer'
require_relative 'player'
require_relative 'game'

interface = Interface.new
dealer_bank = Bank.new
player_bank = Bank.new
game_bank = GameBank.new

Game.new(interface, game_bank, dealer_bank, player_bank)
