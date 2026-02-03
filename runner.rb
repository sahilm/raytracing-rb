# frozen_string_literal: true
RubyVM::YJIT.enable

require_relative './raytracing'

image_width = ARGV[0].nil? ? 1600 : ARGV[0].to_i

main(image_width: image_width)
