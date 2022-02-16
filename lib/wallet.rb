# frozen_string_literal: true

#
# Wallet class dictates
#
class Wallet
  attr_reader :remaining_change

  COIN_VALUES = {
    five: 5.0,
    three: 3.0,
    two: 2.0,
    one: 1.0,
    half: 0.5,
    quarter: 0.25
  }.freeze

  def initialize
    @remaining_change = 40.0
  end

  def display_current_balance
    puts "You have $#{@remaining_change.round(2)} left to spend."
  end

  def make_payment(amount)
    @remaining_change -= amount
    give_back_change
  end

  private

  def give_back_change
    format_change_display(calculate_change)
  end

  def calculate_change
    change = {}
    change_to_convert = @remaining_change
    coin_index = 0

    while change_to_convert.positive?
      current_coin = COIN_VALUES.keys[coin_index]
      if change_to_convert < COIN_VALUES[current_coin]
        coin_index += 1
      else
        change[current_coin] = (change[current_coin] || 1) + 1
        change_to_convert -= COIN_VALUES[current_coin]
      end
    end

    change
  end

  def format_change_display(change)
    puts 'Your change is:'
    change.each do |coin, count|
      puts "#{count} #{coin}#{count > 1 ? 's' : ''}"
    end
  end
end
