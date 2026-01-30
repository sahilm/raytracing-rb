# frozen_string_literal: true

image_width = 256
image_height = 256

puts "P3\n#{image_width} #{image_height}\n255"

(0...image_height).each do |j|
  (0...image_width).each do |i|
    r = i.to_f / (image_width - 1)
    g = j.to_f / (image_height - 1)
    b = 0.0

    ir = (255 * r).to_i
    ig = (255 * g).to_i
    ib = (255 * b).to_i

    puts "#{ir} #{ig} #{ib}"
  end
end
