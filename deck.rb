# frozen_string_literal: true

require_relative 'card.rb'

class Deck
  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  def generate_cards
    cards = []
    GameRules::DEFAULT_POOL_SIZE.times do |_time|
      Card::IMAGES.each do |image|
        Card::VALUES.each do |value|
          cards << Card.new(image, value)
        end
      end
    end

    cards.shuffle
 end
end
