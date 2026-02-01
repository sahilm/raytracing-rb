# frozen_string_literal: true

require_relative './vec3'

class Color < Vec3
  def to_s
    r = self.x
    g = self.y
    b = self.z

    rbyte = (255 * r).to_i
    gbyte = (255 * g).to_i
    bbyte = (255 * b).to_i

    "#{rbyte} #{gbyte} #{bbyte}"
  end
end
