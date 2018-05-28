require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter

  def attach_wagon(wagon)
    if wagon.is_a?(PassengerWagon)
      super(wagon)
    else
      puts 'Тип вагона и тип поезда должны совпадать'
    end
  end

  def type
    ' - пассажирский поезд'
  end
end
