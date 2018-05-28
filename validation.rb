module Validation
  attr_reader :errors

  private

  def validate!
    @errors = []
    raise errors.join(',') unless valid?
  end
end
