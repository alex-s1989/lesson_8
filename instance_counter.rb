module InstanceCounter
  def self.included(class_name)
    class_name.extend(ClassMethods)
    class_name.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_reader :count

    def instances
      @count ||= 0
      @count += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances
    end
  end
end
