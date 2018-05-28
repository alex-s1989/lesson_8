require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :list_stations

  def initialize(start_station, finish_station)
    @list_stations = [start_station, finish_station]
    validate!
    register_instance
  end

  def add_interval_stations(station)
    list_stations.insert(-2, station)
  end

  def delete_interval_stations(station)
    list_stations.delete(station)
  end

  def print_route
    list_stations.each { |station| puts station }
  end

  def to_s
    "#{list_stations.first} - #{list_stations.last}"
  end

  private

  def valid?
    errors << 'Введен несуществующий индекс начальной станции' unless list_stations[0].is_a?(Station)
    errors << 'Введен несуществующий индекс конечной станции' unless list_stations[1].is_a?(Station)

    errors.size.zero?
  end
end
