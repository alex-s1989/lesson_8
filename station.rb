require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_accessor :trains
  attr_reader :name

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def arrival_train(train)
    trains << train
  end

  def departure_train(train)
    trains.delete(train)
  end

  def to_s
    name
  end

  def each_train
    trains.each { |train| yield train }
  end

  private

  def valid?
    errors << 'Введена пустая строка' if name.nil? || name.strip.size.zero?
    errors << 'Имя станции слишком длинное. Максимальное количество символов - 20' if name.length > 20

    errors.size.zero?
  end
end
