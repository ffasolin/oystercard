class JourneyLog

  attr_reader :journey_class

  def initialize (journey_class = Journey.new)
    @journey_class = journey_class
  end

  def start(entry_station)
    @journey_class.journey_start(entry_station)
  end

  def finish(exit_station)
    @journey_class.journey_end(exit_station)
  end

  def current_journey
    if journey_class.journey_complete

       if in_journey?
    touch_in(nil) if !in_journey?
  end

  def journeys
  end

end
