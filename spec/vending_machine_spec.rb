# frozen_string_literal: true

require_relative '../lib/not_enough_coins_error'
require_relative '../lib/wallet'
require_relative '../lib/vending_machine'

describe 'vending_machine' do
  it 'should create a new vending machine' do
    vending_machine = VendingMachine.new
    expect(vending_machine).to be_an_instance_of(VendingMachine)
  end

  it 'should properly display items' do
    vending_machine = VendingMachine.new
    expect { vending_machine.display_items }.to output(
      "-------------------------\nVending Machine Items:\n1\) " \
      "$15.5 - pizzas\n2\) $2.75 - cupcakes\n3\) $9.5 - burritos\n4\) " \
      "$10.0 - mashed_potatoes\n5\) $1.25 - water\n-------------------------\n"
    ).to_stdout
  end
end

describe 'correct_change_calcutations' do
  it 'returns correct change' do
    wallet = Wallet.new
    vending_machine = VendingMachine.new
    vending_machine.send(:return_change, :pizzas, wallet)
    # Remaining $24.5
    expect(wallet.send(:calculate_change, wallet.remaining_change)).to eq(
      { five: 4,
        three: 1,
        one: 1,
        half: 1 }
    )

    wallet.make_payment(16.75)
    # Remaining $7.75
    expect(wallet.send(:calculate_change, wallet.remaining_change)).to eq(
      { five: 1,
        two: 1,
        half: 1,
        quarter: 1 }
    )
    expect { wallet.display_current_balance }.to output("You have $7.75 left to spend.\n").to_stdout
  end

  it 'should raise an error when there are not enough coins to return' do
    vending_machine = VendingMachine.new
    wallet = Wallet.new
    expect { 5.times { vending_machine.send(:return_change, :water, wallet) } }.to raise_error(NotEnoughCoinsError)
  end
end
