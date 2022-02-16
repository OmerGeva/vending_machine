# frozen_string_literal: true

require_relative 'vending_machine'
require_relative 'wallet'
require_relative 'router'

vending_machine = VendingMachine.new
wallet = Wallet.new
router = Router.new(vending_machine, wallet)
router.run
