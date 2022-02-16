# frozen_string_literal: true

#
# Class that helps orchestrate actions based on user input
#
class Router
  def initialize(vending_machine, wallet)
    @vending_machine = vending_machine
    @wallet = wallet
    @running = true
  end

  def run
    puts 'Welcome to the vending machine!'
    puts "You have #{@wallet.remaining_change} to spend. Here are your options:"
    while @running
      display_actions
      action = gets.chomp.to_i
      dispatch_action(action)
    end
    puts 'Thank you for shopping, hope to see you soon!'
  end

  private

  def display_actions
    puts '1) List available items'
    puts '2) Purchase an item'
    puts '3) See remaining balance'
    puts '4) Exit vending machine'
    puts 'What would you like to do? (Enter a number)'
    print '> '
  end

  def dispatch_action(action)
    case action
    when 1 then @vending_machine.display_items
    when 2 then @vending_machine.purchase_item(@wallet)
    when 3 then @wallet.display_current_balance
    when 4 then exit_vending_machine
    else
      puts 'Please enter a valid option.'
    end
    puts '-------------------------'
  end

  def exit_vending_machine
    @running = false
  end
end
