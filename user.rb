# frozen_string_literal: true

class User
  attr_reader :name, :cards
  attr_accessor :passed_the_move, :took_the_card, :opened_cards, :bank

  def initialize(name, bank)
    @name = name
    @cards = []
    @passed_the_move = false
    @took_the_card = false
    @opened_cards = false
    @bank = bank
  end

  def take_cards(cards)
    @cards.concat(cards) if can_take_cards?
  end

  def show_cards_back
    @cards.each { print('*') }
    Printer.double_line
  end

  def show_cards_face
    @cards.each { |card| print("#{card.value}  #{card.image}") }
    Printer.double_line
  end

  def cards_limit_reached?
    @cards.size == GameRules::MAX_CARDS_COUNT
  end

  def clear_cards
    @cards = []
    @passed_the_move = false
    @took_the_card = false
    @opened_cards = false
  end

  def  accept_bet
    @bank.credit
  end

  def increase_balance
    @bank.debit
  end

  protected

  def pass_move
    Printer.show("#{name} pass the move.")
    self.passed_the_move = true
  end

  def take_card(card)
    Printer.show("#{name} take a card.")
    take_cards(card)
    self.took_the_card = true
  end

  def open_cards
    Printer.show("#{name} want to open cards.")
    self.opened_cards = true
  end

  def can_take_cards?
    @cards.size < 3
  end

  def can_open_cards?(command)
    command == 'o'
  end
end
