class JourneyLog
  attr_reader :current_journey, :oystercard

  def initialize(current_journey = Journey.new)
    @current_journey = current_journey
  end

  def start(entry_station)
    @current_journey.journey_start(entry_station)
  end

  def finish(exit_station)
    @current_journey.journey_end(exit_station)
  end
end
