# frozen_string_literal: true

require_relative './color'
require_relative './point3'
require_relative './vec3'
require_relative './ray'

aspect_ratio = 16.0 / 9.0
image_width = 1600
image_height = (image_width / aspect_ratio).to_i

focal_length = 1.0
viewport_height = 2.0
viewport_width = viewport_height * (image_width / image_height).to_f
camera_center = Point3.new(0, 0, 0)

viewport_u = Vec3.new(viewport_width, 0, 0)
viewport_v = Vec3.new(0, -viewport_height, 0)

pixel_delta_u = viewport_u / image_width
pixel_delta_v = viewport_v / image_height

viewport_upper_left = camera_center - Vec3.new(0, 0, focal_length) - viewport_u / 2 - viewport_v / 2
pixel00_loc = viewport_upper_left + ((pixel_delta_u + pixel_delta_v) / 2)

puts "P3\n#{image_width} #{image_height}\n255"

(0...image_height).each do |j|
  STDERR.print("\rScanlines remaining: #{image_height - j}")
  STDERR.flush
  (0...image_width).each do |i|
    # color = Color.new(
    #   i.to_f / (image_width - 1),
    #   j.to_f / (image_height - 1),
    #   0.0
    # )
    pixel_center = pixel00_loc + (pixel_delta_u * i) + (pixel_delta_v * j)
    ray_direction = pixel_center - camera_center
    ray = Ray.new(camera_center, ray_direction)

    color = ray.color
    puts color
  end
end
