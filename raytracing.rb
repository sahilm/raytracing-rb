# frozen_string_literal: true
RubyVM::YJIT.enable

class Vector
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def -@
    Vector.new(-x, -y, -z)
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

  def dot(other)
    x * other.x + y * other.y + z * other.z
  end

  def ==(other)
    @x == other.x && @y == other.y && @z == other.z
  end

  def to_s
    "#{x} #{y} #{z}"
  end
end

class Color < Vector
  def to_s
    rbyte = (255 * self.x).to_i
    gbyte = (255 * self.y).to_i
    bbyte = (255 * self.z).to_i

    "#{rbyte} #{gbyte} #{bbyte}"
  end
end

class Ray
  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def at(t)
    origin + (direction * t)
  end

  def color
    unit_direction = direction.unit_vector
    a = 0.5 * (unit_direction.y + 1.0)
    Color.new(1.0, 1.0, 1.0) * (1.0 - a) + (Color.new(0.5, 0.7, 1.0) * a)
  end
end

def hit_sphere(center, radius, ray)
  # C = center, Q = ray.origin
  oc = center - ray.origin
  # a = 2d
  a = ray.direction.dot(ray.direction)
  # b = -2d . * (C-Q)
  b = -2.0 * ray.direction.dot(oc)
  # c = (C - Q) . (C - Q) - r * r
  c = oc.dot(oc) - radius * radius
  discriminant = b * b - 4 * a * c

  if discriminant < 0
    -1.0
  else
    (-b - Math.sqrt(discriminant)) / (2.0 * a)
  end
end

def main(image_width: 1600)
  aspect_ratio = 16.0 / 9.0
  image_height = (image_width / aspect_ratio).to_i

  focal_length = 1.0
  viewport_height = 2.0
  viewport_width = viewport_height * (image_width.to_f / image_height)
  camera_center = Vector.new(0, 0, 0)

  viewport_u = Vector.new(viewport_width, 0, 0)
  viewport_v = Vector.new(0, -viewport_height, 0)

  pixel_delta_u = viewport_u / image_width
  pixel_delta_v = viewport_v / image_height

  viewport_upper_left = camera_center - Vector.new(0, 0, focal_length) - viewport_u / 2 - viewport_v / 2
  pixel00_loc = viewport_upper_left + ((pixel_delta_u + pixel_delta_v) * 0.5)

  puts "P3\n#{image_width} #{image_height}\n255"
  sphere_center = Vector.new(0, 0, -1)

  (0...image_height).each do |j|
    STDERR.print("\rScanlines remaining: #{image_height - j}")
    STDERR.flush
    (0...image_width).each do |i|
      pixel_center = pixel00_loc + (pixel_delta_u * i) + (pixel_delta_v * j)
      ray_direction = pixel_center - camera_center
      ray = Ray.new(camera_center, ray_direction)
      hit = hit_sphere(sphere_center, 0.5, ray)

      if hit > 0.0
        surface_normal = (ray.at(hit) - sphere_center).unit_vector
        puts(Color.new(surface_normal.x + 1, surface_normal.y + 1, surface_normal.z + 1) * 0.5)
      else
        puts ray.color
      end
    end
  end
end
