# frozen_string_literal: true

# Serializer for required response
class Serializer
  class << self
    attr_reader :attributes

    def attribute(attribute, &block)
      @attributes ||= {}
      @attributes[attribute] = block
    end
  end

  attr_reader :object

  def initialize(object)
    @object = object
  end

  def serialize
    data = {}

    self.class.attributes.each do |attr, block|
      data[attr] = object.send(attr)
      data[attr] = instance_eval(&block) unless block.nil?
    end

    data.compact
  end
end
