require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

class Railway
  attr_reader :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station(name)
    station = Station.new(name)
    stations << station
  end

  def create_cargo_train(train_number)
    train = CargoTrain.new(train_number)
    trains << train
  end

  def create_passenger_train(train_number)
    train = PassengerTrain.new(train_number)
    trains << train
  end

  def create_cargo_wagon(number, whole_volume)
    wagon = CargoWagon.new(number, whole_volume)
    wagons << wagon
  end

  def create_passenger_wagon(number, number_of_places)
    wagon = PassengerWagon.new(number, number_of_places)
    wagons << wagon
  end

  def create_route(start_station_index, finish_station_index)
    start_station = station_by_index(start_station_index)
    finish_station = station_by_index(finish_station_index)

    route = Route.new(start_station, finish_station)
    routes << route
  end

  def add_interval_stations(route_index, station_index)
    route = route_by_index(route_index)
    station = station_by_index(station_index)

    route.add_interval_stations(station)
  end

  def delete_interval_stations(route_index, station_index)
    route = route_by_index(route_index)
    station = station_by_index(station_index)

    route.delete_interval_stations(station)
  end

  def take_route(train_index, route_index)
    train = train_by_index(train_index)
    route = route_by_index(route_index)
    train.take_route(route)
  end

  def attach_wagon(train_index, wagon_index)
    train = train_by_index(train_index)
    wagon = wagon_by_index(wagon_index)
    if trains.find { |train| train.wagons.find { |wag| wag == wagon } }
      puts "  -данный вагон занят, он уже прицеплен к поезду №#{train.train_number}"
    else train.attach_wagon(wagon)
         puts "  -вагон №#{wagon.number} успешно прицеплен к составу поезда №#{train.train_number}"
    end
  end

  def unhook_wagon(train_index, wagon_index)
    train = train_by_index(train_index)
    train.unhook_wagon(wagon_index)
    puts "  -вагон успешно отцеплен от состава поезда №#{train.train_number}"
  end

  def move_ahead(train_index)
    train = train_by_index(train_index)
    train.move_ahead
  end

  def move_back(train_index)
    train = train_by_index(train_index)
    train.move_back
  end

  def show_stations
    stations.each_index do |station_index|
      show_station(station_index)
    end
  end

  def show_station(station_index)
    station = station_by_index(station_index)

    puts "Станция: #{station}"
    puts '  Поезда:'
    station.each_train do |train|
      puts train
      puts '    вагоны:'
      train.each_wagon { |wagon| puts wagon }
    end
  end

  def stations_with_index
    puts "Количество станций: #{Station.count}"

    stations.each_with_index { |station, index| puts "№#{index} - #{station}" }
  end

  def trains_with_index
    puts "Количество поездов: #{(CargoTrain.count || 0) + (PassengerTrain.count || 0)}"

    trains.each_with_index do |train, index|
      puts " #{index} - #{train}"
    end
  end

  def routes_with_index
    puts "Количество маршрутов: #{Route.count}"

    routes.each_with_index { |route, index| puts "#{index} - #{route}" }
  end

  def wagons_with_index
    wagons.each_with_index { |wagon, index| puts " #{index}: #{wagon}" }
  end

  def free_wagons
    wagons.reject { |wagon| trains.find { |train| train.wagons.find { |wag| wag == wagon } } }
  end

  def free_wagons_with_index
    free_wagons.each_with_index { |wagon, index| puts " #{index}: #{wagon}" }
  end

  def train_by_index(index)
    trains[index]
  end

  def take_places(wagon_index, index)
    wagon = wagon_by_index(wagon_index)
    wagon.take_places(index)
    puts "  -место №#{index} успешно забронировано в вагоне №#{wagon.number} "
  end

  def take_volume(wagon_index, volume)
    wagon = wagon_by_index(wagon_index)
    wagon.take_volume(volume)
    puts "  -груз объемом #{volume} м*3 успешно помещен в вагон4 №#{wagon.number} "
  end

  private

  attr_writer :stations, :trains, :routes, :wagons

  def route_by_index(index)
    routes[index]
  end

  def station_by_index(index)
    stations[index]
  end

  def wagon_by_index(index)
    wagons[index]
  end
end
