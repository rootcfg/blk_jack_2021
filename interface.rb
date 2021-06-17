# frozen_string_literal: true

class Interface
  def prompt
    gets.strip
  end

  def player_name
    puts 'Please enter your name.'.blue
    name = prompt
    raise unless name != ''

    name
  rescue StandardError
    puts 'Name cannot be blank. Please try again.'.blue
    retry
  end

  def command(user)
    ask_user_move(user)
    code = prompt
    exit_game if code == 'q'
    raise unless %w[p t o].include? code

    code
  rescue StandardError
    puts 'Command is invalid. Please try again.'.blue
    retry
  end

  def think
    Printer.show("#{name} waiting...".white)
    sleep(GameRules::TIME)
  end

  def ask_user_move(user)
    puts "\nYour choise?".blue
    puts "'p': Pass move.".blue unless user.passed_the_move
    puts "'t': Get one card.".blue unless user.took_the_card
    puts "'o': Open cards.".blue
    puts "'q' Quit.".blue
  end

  def confirm_open_cards
    Printer.show('Press any key to open cards...'.blue)
    gets
  end

  def confirm_start_new_game
    Printer.show('Press any key to continue...'.blue)
    gets
  end

  def game_greeting
    Printer.show('******* WELCOME TO GAME! **********'.blue)
  end

  def player_greeting(name)
    Printer.show("Hi, #{name}!".blue)
  end

  def exit_game
    Printer.show('GAME OVER!'.red)
    exit
  end

  def start_new_game
    Printer.show('Starting.....'.blue)
  end

  def drawn_game
    Printer.show('Drawn.....'.blue)
  end

  def show_base_commands
    puts "'n': start new game.".blue
    puts "'q': to quit.".blue
  end

  def show_score(name, score)
    puts "#{name}'s scores: #{score}".green
  end

  def perebor
    Printer.print_message("Perebor".red)
  end

  def show_bank(bank)
    puts "Bank: #{bank.amount}".green
  end
end
