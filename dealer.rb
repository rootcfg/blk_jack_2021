# frozen_string_literal: true

class Dealer < User
  def initialize(name = 'Dealer', bank)
    super(name, bank)
  end

  def process_move(hand)
    if can_pass?(hand.score(@cards))
      pass_move
    elsif can_take_card?
      take_card(hand.deal_one_card)
    else
      open_cards
    end
  end

  protected

  def can_pass?(score)
    score >= GameRules::PASS_SCORE && !@passed_the_move
  end

  def can_take_card?
    !@took_the_card
  end
end
