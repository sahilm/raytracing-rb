# frozen_string_literal: true

require_relative './vec3'
require_relative './color'

class Ray
  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def at(t)
    origin + t * direction
  end

  def color
    unit_direction = direction.unit_vector
    a = 0.5 * (unit_direction.y + 1.0)
    Color.new(1.0, 1.0, 1.0) * (1.0 - a) + (Color.new(0.5, 0.7, 1.0) * a)
  end
end
