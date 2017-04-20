require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :history, :journey
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @history = []
    @journey = nil
  end

  def top_up(value)
    message = "card limit exceeded: Maximum Balance is £#{MAXIMUM_BALANCE}"
    raise message if value + balance > MAXIMUM_BALANCE
    @balance += value
  end


  def touch_in(entry_station)
    #touch_out(nil) if in_journey?
    raise "Min balance is £1" if @balance < MINIMUM_FARE
    #@journey = Journey.new
    #@journey.journey_start(entry_station)
    @journey = JourneyLog.new
    @journey.start(entry_station)

  end

  def touch_out(exit_station)
    #touch_in(nil) if !in_journey?
    history.push ({ @journey.journey_class.entry_station => exit_station })
    #@journey.journey_end(exit_station)
    @journey.finish(exit_station)
    deduct(@journey.journey_class.fare)
    @journey.journey_class = nil
  end

  #def in_journey?
  #  @journey.journey_class != nil
  #end

  private

  def deduct(x)
    @balance -= x
  end

end
