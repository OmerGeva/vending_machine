# frozen_string_literal: true

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

  def initialize
    @remaining_items = ORIGINAL_ITEM_COUNT.dup
  end

  def display_items
    format_item_display
  end

  def purchase_item(wallet)
    puts 'Please select an item (Enter a number)'
    item = find_item
    return unless item

    error = validate_option(item, wallet.remaining_change)
    puts error
    return if error

    return_change(item, wallet)
    decrease_count(item)
    puts 'Thank you for using the vending machine'
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
    if @remaining_items[item][:count].zero?
      "Sorry, there are no more available #{item}, please choose another option."
    elsif @remaining_items[item][:cost] > balance
      "You do not have enough money to buy #{item}."
    end
  end

  def decrease_count(item)
    @remaining_items[item][:count] -= 1
  end

  def return_change(item, wallet)
    wallet.make_payment(@remaining_items[item][:cost])
  end
end
