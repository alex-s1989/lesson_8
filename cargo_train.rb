require_relative 'train'

class CargoTrain < Train
  include InstanceCounter

  def attach_wagon(wagon)
    if wagon.is_a?(CargoWagon)
      super(wagon)
    else
      puts 'Тип вагона и тип поезда должны совпадать'
    end
  end

  def type
    ' - грузовой поезд'
  end
end
