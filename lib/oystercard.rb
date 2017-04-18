class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :status, :station

  def initialize
  	@balance = 0
    @status = "New card."
  end

  def top_up(amount)
    message = "ERROR: balance over maximum limit of #{MAX_BALANCE}"
    fail message if @balance + amount > MAX_BALANCE
  	@balance = @balance + amount
  end

  def touch_in(station)
    fail "Insufficient balance." if @balance < MIN_BALANCE
    @status = "Touched in."
    @station = station
  end

  def touch_out
    deduct(1)
    @status = "Touched out."
    @station = nil
  end

  def in_journey?
    #return true if @status == "Touched in." # true and false not required because == is already compairing
    #false
    @station != nil
  end

  private
  def deduct(amount)
    @balance = @balance - amount
  end

end
