# frozen_string_literal: true
RubyVM::YJIT.enable

require_relative './raytracing'

main(image_width: 400)
