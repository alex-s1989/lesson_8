require_relative 'wagon'

class CargoWagon < Wagon
  def post_initialize(args)
    @whole_volume = args[:whole_volume]
    @taken_volume = 0
  end

  def take_volume(volume)
    raise 'Нет свободного объема' if volume > whole_volume
    @taken_volume += volume
  end

  def available_volume
    whole_volume - taken_volume
  end

  def to_s
    "     - грузовой вагон №#{number}, свободный объем в вагоне: #{available_volume} m*3, занятый объем: #{taken_volume} m*3"
  end

  private

  attr_reader :whole_volume, :taken_volume
end
