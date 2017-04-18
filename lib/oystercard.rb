class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
  	@balance = 0
  end

  def top_up(amount)
    fail "ERROR: balance over maximum limit of #{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
  	@balance = @balance + amount
  end

end
