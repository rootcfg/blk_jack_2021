# frozen_string_literal: true

class Printer
  def self.show(message)
    puts
    print_message(message)
    puts
  end

  def self.print_line
    puts
  end

  def self.double_line
    print_line
    print_line
  end

  def self.print_message(message)
    line = '========================================================='
    puts line
    puts message.to_s
    puts line
  end
end
