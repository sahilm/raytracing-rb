# frozen_string_literal: true

RubyVM::YJIT.enable

require_relative './color'
require_relative './point3'
require_relative './vec3'
require_relative './ray'

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
  discriminant >= 0
end

aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = (image_width / aspect_ratio).to_i

focal_length = 1.0
viewport_height = 2.0
viewport_width = viewport_height * (image_width.to_f / image_height)
camera_center = Point3.new(0, 0, 0)

viewport_u = Vec3.new(viewport_width, 0, 0)
viewport_v = Vec3.new(0, -viewport_height, 0)

pixel_delta_u = viewport_u / image_width
pixel_delta_v = viewport_v / image_height

viewport_upper_left = camera_center - Vec3.new(0, 0, focal_length) - viewport_u / 2 - viewport_v / 2
pixel00_loc = viewport_upper_left + ((pixel_delta_u + pixel_delta_v) * 0.5)

puts "P3\n#{image_width} #{image_height}\n255"

(0...image_height).each do |j|
  STDERR.print("\rScanlines remaining: #{image_height - j}")
  STDERR.flush
  (0...image_width).each do |i|
    pixel_center = pixel00_loc + (pixel_delta_u * i) + (pixel_delta_v * j)
    ray_direction = pixel_center - camera_center
    ray = Ray.new(camera_center, ray_direction)

    if hit_sphere(Point3.new(0, 0, -1), 0.5, ray)
      puts Color.new(1, 0.411, 0.7)
    else
      puts ray.color
    end
  end
end
