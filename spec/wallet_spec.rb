# frozen_string_literal: true

require 'wallet'

describe 'wallet_class' do
  it 'should create a new wallet' do
    wallet = Wallet.new
    expect(wallet).to be_an_instance_of(Wallet)
  end

  it 'should see initial balance as 40.0' do
    wallet = Wallet.new
    expect(wallet.remaining_change).to equal(40.0)
  end

  it 'display balance correctly' do
    wallet = Wallet.new
    expect(wallet.remaining_change).to equal(40.0)
    expect { wallet.display_current_balance }.to output("You have $40.0 left to spend.\n").to_stdout
  end
end

describe 'correct_change_calcutations' do
  it 'returns correct change' do
    wallet = Wallet.new
    vending_machine = VendingMachine.new
    vending_machine.send(:return_change, :pizzas, wallet)
    # Remaining $24.5
    expect(wallet.send(:calculate_change)).to eq(
      {
        five: 4,
        three: 1,
        one: 1,
        half: 1
      }
    )

    wallet.make_payment(16.75)
    # Remaining $7.75
    expect(wallet.send(:calculate_change)).to eq(
      {
        five: 1,
        two: 1,
        half: 1,
        quarter: 1
      }
    )
    expect { wallet.display_current_balance }.to output("You have $7.75 left to spend.\n").to_stdout
  end
end
