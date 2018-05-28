require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :number_of_places, :places

  def post_initialize(args)
    @places = []
    @number_of_places = args[:number_of_places]

    init_places
  end

  def take_places(index)
    index = number_place(index)
    raise 'Неправильное место' if index > number_of_places

    if @places[index]
      raise 'Это место уже занято. Выберите другое'
    else
      @places[index] = true
    end
  end

  def number_booked_places
    booked_places.count
  end

  def number_free_places
    free_places.count
  end

  def free_places
    places.reject(&:!)
  end

  def booked_places
    places.select { |place| place }
  end

  def to_s
    "     - пассажирский вагон №#{number}, свободных мест в вагоне: #{number_free_places}, занятых мест: #{number_booked_places}"
  end

  private

  def init_places
    @places = Array.new(number_of_places, false)
  end

  def number_place(index)
    index - 1
  end
end
