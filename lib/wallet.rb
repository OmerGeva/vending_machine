# frozen_string_literal: true

#
# Wallet class defines behavior of storing money and calculating change in coins
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
  end

  def calculate_change(amount)
    compute_change(amount)
  end

  private

  def compute_change(change_to_convert, change = {}, coin_index = 0)
    while change_to_convert.positive?
      current_coin = COIN_VALUES.keys[coin_index]
      if change_to_convert < COIN_VALUES[current_coin]
        coin_index += 1
      else
        change[current_coin] = (change[current_coin] || 0) + 1
        change_to_convert -= COIN_VALUES[current_coin]
      end
    end

    change
  end
end
