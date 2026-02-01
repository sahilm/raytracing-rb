# frozen_string_literal: true

class Vec3
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def -@
    Vec3.new(-x, -y, -z)
  end

  def +(other)
    self.class.new(x + other.x, y + other.y, z + other.z)
  end

  def -(other)
    self.class.new(x - other.x, y - other.y, z - other.z)
  end

  def *(scalar)
    self.class.new(scalar * x, scalar * y, scalar * z)
  end

  def /(scalar)
    self.class.new(x / scalar, y / scalar, z / scalar)
  end

  def length
    Math.sqrt(x * x + y * y + z * z)
  end

  def unit_vector
    self / length
  end

  def ==(other)
    @x == other.x && @y == other.y && @z == other.z
  end

  def to_s
    "#{x} #{y} #{z}"
  end
end
