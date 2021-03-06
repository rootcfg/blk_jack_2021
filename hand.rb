# frozen_string_literal: true

class Hand

  def initialize
    deck = Deck.new
    @cards = deck.cards
  end

  def deal_cards(count = 2)
    @cards.sample(count).each { |value| @cards.delete(value) }
  end

  def deal_one_card
    deal_cards(1)
  end

  def score(cards)
    total_score = 0
    ace_count = 0
    cards.each do |card|
      ace_count += GameRules::ACE_MIN_VALUE if card.value == 'A'
      total_score += get_card_score(card)
    end
    add_additional_ace_score(total_score, ace_count)
  end

  def drawn?(player_score, dealer_score)
    player_score == dealer_score
  end

  def player_win?(player_score, dealer_score)
    win_score?(player_score) || player_less_difference?(player_score, dealer_score)
  end

  def player_less_difference?(player_score, dealer_score)
    score_difference(player_score) < score_difference(dealer_score)
  end

  protected

  def get_card_score(card)
    if %w[J Q K].include? card.value
      GameRules::DEFAULT_VALUE
    elsif card.value == 'A'
      GameRules::ACE_MIN_VALUE
    else
      card.value.to_i
    end
  end

  def add_additional_ace_score(total_score, ace_count)
    ace_count.times do
      ace_score = GameRules::ACE_MAX_VALUE - GameRules::ACE_MIN_VALUE
      total_score += ace_score if total_score + ace_score <= GameRules::WIN_SCORE + 5
    end
    total_score
  end

  def win_score?(score)
    GameRules::WIN_SCORE == score
  end

  def score_difference(score)
    (GameRules::WIN_SCORE - score).abs
  end
end
