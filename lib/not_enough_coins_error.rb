# frozen_string_literal: true

#
# Error class that inherits from StandardError, is thrown when there are not enough coins for the machine to return.
#
class NotEnoughCoinsError < StandardError
  attr_reader :msg

  def initialize(msg = 'The machine does not have enough coins to return to you. Try again later.')
    @msg = msg
    super(msg)
  end
end
