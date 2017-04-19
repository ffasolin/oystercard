class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :status, :entry_station, :exit_station, :journey_history

  def initialize
  	@balance = 0
    @status = "New card."
    @journey_history = []
  end

  def top_up(amount)
    message = "ERROR: balance over maximum limit of #{MAX_BALANCE}"
    fail message if @balance + amount > MAX_BALANCE
  	@balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient balance." if @balance < MIN_BALANCE
    @status = "Touched in."
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(1)
    @status = "Touched out."
    @exit_station = exit_station
    journey_record
  end

  def in_journey?
    @entry_station != nil
  end

  def journey_record
    journey = { @entry_station => exit_station }
    @journey_history << journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
