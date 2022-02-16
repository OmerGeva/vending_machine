# frozen_string_literal: true

require 'vending_machine'

describe 'vending_machine' do
  it 'should create a new vending machine' do
    vending_machine = VendingMachine.new
    expect(vending_machine).to be_an_instance_of(VendingMachine)
  end
end
