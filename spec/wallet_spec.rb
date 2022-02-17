# frozen_string_literal: true

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
