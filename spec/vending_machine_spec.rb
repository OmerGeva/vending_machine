# frozen_string_literal: true

require 'vending_machine'

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
