class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :status

  def initialize
  	@balance = 0
    @status = "New card."
  end

  def top_up(amount)
    message = "ERROR: balance over maximum limit of #{MAX_BALANCE}"
    fail message if @balance + amount > MAX_BALANCE
  	@balance = @balance + amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def touch_in
    fail "Insufficient balance." if @balance < MIN_BALANCE
    @status = "Touched in."
  end

  def touch_out
    @status = "Touched out."
  end

  def in_journey?
    return true if @status == "Touched in."
    false
  end

end
