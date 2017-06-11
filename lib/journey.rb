require_relative 'oystercard'

class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def journey_start(entry_station)
    @entry_station = entry_station
  end

  def journey_end(exit_station)
    @exit_station = exit_station
  end

  def journey_complete?
    @entry_station != nil && @exit_station != nil
  end

  def fare
    if journey_complete?
      puts "Journey complete."
      return 1
    else
      puts "Incomplete Journey Detected! you've been charged accordingly."
      return 6
    end
  end
end
