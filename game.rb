# frozen_string_literal: true

class Game

  def initialize(interface, game_bank, dealer_bank, player_bank)
    @interface = interface
    @interface.game_greeting
    @player = Player.new(@interface.player_name, player_bank)
    @interface.player_greeting(@player.name)
    @dealer = Dealer.new(dealer_bank)
    @interface.show_base_commands
    @bank = game_bank
    while (code = @interface.prompt)
      process_prompt(code)
    end
  end

  protected

  attr_accessor :bank, :game_over

  def process_prompt(code)
    if code == 'n'
      start_game
    elsif code == 'q'
      @interface.exit_game
    else
      puts 'Bad command!'.red
    end
  end

  def start_game
    @interface.start_new_game
    @bank.amount = 0
    @game_over = false
    @hand = Hand.new
    accept_bets
    deal_cards
    play_game
    open_cards
  end

  def accept_bets
    @bank.amount += @player.accept_bet
    @bank.amount += @dealer.accept_bet
  end

  def deal_cards
    @player.take_cards(@hand.deal_cards)
    @dealer.take_cards(@hand.deal_cards)
  end

  def play_game
    until @game_over
      player_move
      break if @game_over || players_cards_limit_reached?

      dealer_move
      stop_game if players_cards_limit_reached?
    end
  end

  def player_move
    show_info
    @player.process_move(@interface.command(@player), @hand)
    self.game_over = @player.opened_cards
  end

  def dealer_move
    show_info
    @dealer.process_move(@hand)
    self.game_over = @dealer.opened_cards
  end

  def open_cards
    self.game_over = true
    @interface.confirm_open_cards
    determine_winner
    show_info
    collect_cards
    show_balances
    if players_cannot_play?
      @interface.exit_game
      clear_bank
    end
    @interface.show_base_commands
  end

  def collect_cards
    @player.clear_cards
    @dealer.clear_cards
  end

  def show_balances
    Printer::print_message(@player.bank.amount)
    Printer::print_message(@dealer.bank.amount)
  end

  def show_info
    @dealer.show_cards_back unless @game_over
    @dealer.show_cards_face if @game_over
    @player.show_cards_face

    @interface.show_score(@dealer.name, @hand.score(@dealer.cards)) if @game_over
    @interface.show_score(@player.name, @hand.score(@player.cards))

    @interface.show_bank(@bank)
  end

  def stop_game
    show_info
    self.game_over = true
  end

  def determine_winner
    player_score = @hand.score(@player.cards)
    dealer_score = @hand.score(@dealer.cards)
    if player_score > GameRules::WIN_SCORE || dealer_score > GameRules::WIN_SCORE
      @interface.perebor
      players_increase_balance
      stop_game
    elsif @hand.drawn?(player_score, dealer_score)
      @interface.drawn_game
      players_increase_balance
    elsif @hand.player_win?(player_score, dealer_score)
      2.times { @player.increase_balance }
      @bank.debit
    else
      2.times { @dealer.increase_balance }
      @bank.debit
    end
  end

  def players_increase_balance
    @dealer.increase_balance
    @player.increase_balance
  end

  def clear_bank
    @bank.refund(@dealer, @player)
  end

  def players_cards_limit_reached?
    @player.cards_limit_reached? && @dealer.cards_limit_reached?
  end

  def players_cannot_play?
    @player.bank.amount == 0 || @dealer.bank.amount == 0
  end
end
