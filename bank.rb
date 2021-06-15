# frozen_string_literal: true

class Bank
  attr_accessor :amount

  def initialize
    @amount = GameRules::START_BALANCE
  end

  def debit
    @amount -= GameRules::BET_SIZE
  end

  def credit
    @amount += GameRules::BET_SIZE
  end
end

class GameBank < Bank
  def refund(*players)
    players.each do |player|
      player.bank.amount = GameRules::START_BALANCE
    end
  end
end
