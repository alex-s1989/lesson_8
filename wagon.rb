require_relative 'manufacturer_company'
require_relative 'validation'

class Wagon
  include ManufacturerCompany
  include Validation

  attr_reader :number

  NUMBER_FORMAT = /^([а-я]|[a-z]){2}\d{2}$/i

  def initialize(number, args = {})
    @number = number
    validate!
    post_initialize(args)
  end

  def post_initialize(_args)
    nil
  end

  private

  def valid?
    errors << 'Номер имеет неправильный формат' if number !~ NUMBER_FORMAT
    errors.size.zero?
  end
end
