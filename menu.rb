require_relative 'railway'

class Menu
  CREATE_STATION = 1
  CREATE_TRAIN = 2
  CREATE_ROUTE = 3
  CREATE_WAGON = 4
  LIST_STATIONS = 5
  LIST_TRAINS = 6
  LIST_ROUTES = 7
  LIST_WAGONS = 8
  ADD_STATION_TO_ROUTE = 9
  DELETE_STATION_FROM_ROUTE = 10
  TAKE_ROUTE = 11
  ATTACH_WAGON = 12
  UNHOOK_WAGON = 13
  MOVE_AHEAD = 14
  MOVE_BACK = 15
  SHOW_STATIONS = 16
  TAKE_PLACE = 17
  TAKE_VOLUME = 18
  EXIT = 0

  attr_reader :railway

  def initialize
    @railway = Railway.new
  end

  def show_main_menu
    puts 'Выберите пункт меню'
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Создать вагон'
    puts '5. Список станций'
    puts '6. Список поездов'
    puts '7. Список маршрутов'
    puts '8. Список вагонов'
    puts '9. Добавить промежуточную станцию в маршрут'
    puts '10. Удалить промежуточную станцию из маршрута'
    puts '11. Назначить маршрут поезду'
    puts '12. Прицепить вагон к поезду'
    puts '13. Отцепить вагон от поезда'
    puts '14. Переместить поезд на следующую станцию'
    puts '15. Переместить поезд на предыдущую станцию'
    puts '16. Проссмотреть информацию о составах на станциях'
    puts '17. Занять место в пассажирском вагоне'
    puts '18. Занять объем в грузовом вагоне'
    puts '0. Выход'
  end

  def runner
    loop do
      show_main_menu

      index = gets.chomp.to_i
      begin
        case index
        when CREATE_STATION then create_station
        when CREATE_TRAIN then create_train
        when CREATE_ROUTE then create_route
        when CREATE_WAGON then create_wagon
        when LIST_STATIONS then stations_with_index
        when LIST_TRAINS then trains_with_index
        when LIST_ROUTES then routes_with_index
        when LIST_WAGONS then wagons_with_index
        when ADD_STATION_TO_ROUTE then add_interval_stations
        when DELETE_STATION_FROM_ROUTE then delete_interval_stations
        when TAKE_ROUTE then take_route
        when ATTACH_WAGON then attach_wagon
        when UNHOOK_WAGON then unhook_wagon
        when MOVE_AHEAD then move_ahead
        when MOVE_BACK then move_back
        when SHOW_STATIONS then show_stations
        when TAKE_PLACE then take_places
        when TAKE_VOLUME then take_volume
        when EXIT then break
        end
      rescue StandardError => e
        puts "Ошибка валидации: #{e}!"
        retry
      end
    end
  end

  private

  def create_station
    puts 'Введите имя станции:'
    name = gets.chomp
    railway.create_station(name)
  end

  def create_train
    puts 'Выберите тип поезда: 0 - пассажирский; 1 - грузовой'
    type = gets.chomp.to_i
    puts 'Введите номер поезда:'
    puts 'Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса.'
    train_number = gets.chomp
    if type.zero?
      railway.create_passenger_train(train_number)
      puts "Создан пассажирский поезд. Номер поезда №#{train_number}"
    elsif type == 1
      railway.create_cargo_train(train_number)
      puts "Создан грузовой поезд. Номер поезда №#{train_number}"
    else raise 'Введен неправильный индекс при выборе типа поезда'
    end
  end

  def create_route
    railway.stations_with_index

    puts 'Введите индекс начальной станции маршрута'
    start_station_index = gets.chomp.to_i

    puts 'Введите индекс конечной станции маршрута'
    finish_station_index = gets.chomp.to_i

    railway.create_route(start_station_index, finish_station_index)
  end

  def create_wagon
    puts 'Выберите тип вагона: 0 - пассажирский; 1 - грузовой'
    type = gets.chomp.to_i
    puts 'Введите номер вагона:'
    puts 'Допустимый формат: 2 буквы и 2 цифры.'
    wagon_number = gets.chomp
    if type.zero?
      puts 'Введите количество мест в создаваемом вагоне:'
      number_of_places = gets.chomp.to_i
      railway.create_passenger_wagon(wagon_number, number_of_places: number_of_places)
    elsif type == 1
      puts 'Введите объем, который должен быть у создаваемого вагона (от 5 до 150 м*3):'
      whole_volume = gets.chomp.to_i
      raise 'допустимый объем вагона 5..150 м*3' if whole_volume <= 5 || whole_volume >= 150
      railway.create_cargo_wagon(wagon_number, whole_volume: whole_volume)
    else raise 'Введен неправильный индекс при выборе типа вагона'
    end
  end

  def take_places
    puts 'Введите индекс вагона, в котором нужно занять место'
    railway.wagons_with_index
    wagon_index = gets.chomp.to_i
    puts 'Введите номер места в вагоне, которые нужно занять'
    index = gets.chomp.to_i
    railway.take_places(wagon_index, index)
  end

  def take_volume
    puts 'Введите индекс вагона, в котором нужно занять объем'
    railway.wagons_with_index
    wagon_index = gets.chomp.to_i
    puts 'Введите количество объема, которые нужно занять'
    volume = gets.chomp.to_i
    railway.take_volume(wagon_index, volume)
  end

  def stations_with_index
    railway.stations_with_index
  end

  def trains_with_index
    railway.trains_with_index
  end

  def routes_with_index
    railway.routes_with_index
  end

  def wagons_with_index
    railway.wagons_with_index
  end

  def add_interval_stations
    railway.routes_with_index
    puts 'Введите индекс маршрута:'
    route_index = gets.chomp.to_i

    railway.stations_with_index
    puts 'Введите индекс станции для добавления:'
    station_index = gets.chomp.to_i

    railway.add_interval_stations(route_index, station_index)
  end

  def delete_interval_stations
    railway.routes_with_index
    puts 'Введите индекс маршрута:'
    route_index = gets.chomp.to_i

    railway.stations_with_index
    puts 'Введите индекс станции для удаления:'
    station_index = gets.chomp.to_i
    railway.delete_interval_stations(route_index, station_index)
  end

  def take_route
    railway.trains_with_index
    puts 'Введите индекс поезда, которому нужно добавить маршрут:'
    train_index = gets.chomp.to_i

    railway.routes_with_index
    puts 'Введите индекс маршрута:'
    route_index = gets.chomp.to_i

    railway.take_route(train_index, route_index)
  end

  def attach_wagon
    railway.trains_with_index
    puts 'Введите индекс поезда, которому нужно добавить вагон:'
    train_index = gets.chomp.to_i

    railway.free_wagons_with_index
    puts 'Введите индекс вагона для добавления к поезду:'
    wagon_index = gets.chomp.to_i

    railway.attach_wagon(train_index, wagon_index)
  end

  def unhook_wagon
    railway.trains_with_index
    puts 'Введите индекс поезда, от которого нужно отцепить вагон:'
    train_index = gets.chomp.to_i

    railway.train_by_index(train_index).wagons_with_index
    puts 'Введите индекс вагона для отцепления от поезда:'
    wagon_index = gets.chomp.to_i

    railway.unhook_wagon(train_index, wagon_index)
  end

  def move_ahead
    railway.trains_with_index
    puts 'Введите индекс поезда для отправления на следующую станцию:'
    train_index = gets.chomp.to_i

    railway.move_ahead(train_index)
  end

  def move_back
    railway.trains_with_index
    puts 'Введите индекс поезда для отправления на предыдущую станцию:'
    train_index = gets.chomp.to_i

    railway.move_back(train_index)
  end

  def show_stations
    railway.show_stations
  end
end
