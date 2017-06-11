require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :history, :journey_status, :journey
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @history = []
    @journey = JourneyLog.new
  end

  def top_up(amount)
    raise "Limit exceeded £#{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Min balance is £1" if @balance < MINIMUM_FARE
    @journey_status = true
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    history.push({ @journey.current_journey.entry_station => exit_station })
    @journey.finish(exit_station)
    deduct(@journey.current_journey.fare)
    @journey_status = false
  end

  def in_journey?
    !@journey_status.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
