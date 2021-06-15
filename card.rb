# frozen_string_literal: true

class Card
  attr_reader :image, :value

  IMAGES = ['  ♡  ', '  ♧  ', '  ♢  ', '  ♤  '].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(image, value)
    @image = image
    @value = value
  end
end
