# frozen_string_literal: true

require_relative 'not_enough_coins_error'

#
# Vending machine class defines behavior of a vending machine, displaying and purchasing items.
#
class VendingMachine
  ORIGINAL_ITEM_COUNT = {
    pizzas: { count: 10, cost: 15.5 },
    cupcakes: { count: 15, cost: 2.75 },
    burritos: { count: 10, cost: 9.50 },
    mashed_potatoes: { count: 20, cost: 10.0 },
    water: { count: 10, cost: 1.25 }
  }.freeze

  ORIGINAL_COIN_COUNT = {
    five: 20,
    three: 20,
    two: 20,
    one: 20,
    half: 20,
    quarter: 20
  }.freeze

  def initialize
    @remaining_items = ORIGINAL_ITEM_COUNT.dup
    @remaining_coins = ORIGINAL_COIN_COUNT.dup
  end

  def display_items
    format_item_display
  end

  def purchase_item(wallet)
    puts 'Please select an item (Enter a number)'
    item = find_item
    return unless item

    error = validate_option(item, wallet.remaining_change)
    return if error

    change = return_change(item, wallet)
    decrease_count(item)

    format_change_display(change)
  rescue NotEnoughCoinsError => e
    puts e.msg
  end

  private

  def format_item_display
    puts '-------------------------'
    puts 'Vending Machine Items:'
    @remaining_items.each.with_index(1) do |(item, values), i|
      puts "#{i}) $#{values[:cost]} - #{item}"
    end
    puts '-------------------------'
  end

  def format_change_display(change)
    puts 'Your change is:'
    puts "#{change.values.sum} coins are returned, as the following:"
    change.each do |coin, count|
      puts "#{count} #{coin}#{count > 1 ? 's' : ''}"
    end
  end

  def find_item
    choice = gets.chomp.to_i
    case choice
    when 1 then :pizzas
    when 2 then :cupcakes
    when 3 then :burritos
    when 4 then :mashed_potatoes
    when 5 then :water
    else
      puts 'Please pick a valid option.'
    end
  end

  def validate_option(item, balance)
    error =
      if @remaining_items[item][:count].zero?
        "Sorry, there are no more available #{item}, please choose another option."
      elsif @remaining_items[item][:cost] > balance
        "You do not have enough money to buy #{item}."
      end
    puts error if error
    error
  end

  def decrease_count(item)
    @remaining_items[item][:count] -= 1
  end

  def return_change(item, wallet)
    change = wallet.calculate_change(wallet.remaining_change - @remaining_items[item][:cost])
    change.each do |coin, count|
      raise NotEnoughCoinsError if @remaining_coins[coin] < count

      @remaining_coins[coin] -= count
    end
    wallet.make_payment(@remaining_items[item][:cost])
    change
  end
end
