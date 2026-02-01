# frozen_string_literal: true

require 'rspec'
require_relative '../vec3'

describe Vec3 do
  describe 'unary negation' do
    it 'returns the negation of the vector' do
      expect(-Vec3.new(1, 2, 3)).to eq(Vec3.new(-1, -2, -3))
    end
  end

  describe "+" do
    it 'returns a sum of the vectors' do
      v1 = Vec3.new(1, 2, 3)
      v2 = Vec3.new(4, 5, 6)
      v3 = Vec3.new(5, 7, 9)

      expect(v1 + v2).to eq(v3)
    end
  end

  describe "-" do
    it 'subtracts two vector' do
      v1 = Vec3.new(1, 2, 3)

      v2 = Vec3.new(41.1, 52.3, 6)
      v3 = Vec3.new(-40.1, -50.3, -3)

      expect(v1 - v2).to eq(v3)
    end
  end

  describe "*" do
    it 'returns a scaled vector' do
      v1 = Vec3.new(1.0, 2.0, 3.4)
      expect(v1 * 3).to eq(Vec3.new(3.0, 6.0, 10.2))
    end
  end

  describe '/' do
    it 'returns a scaled vector' do
      v1 = Vec3.new(3.0, 6.0, 9.0)
      expect(v1 / 3).to eq(Vec3.new(1.0, 2.0, 3.0))
    end
  end

  describe 'length' do
    it 'returns the magnitude of the vector' do
      v1 = Vec3.new(1, 2, 3)
      expect(v1.length).to eq(Math.sqrt(14))
    end
  end

  describe 'to_s' do
    it 'returns a string representation' do
      v1 = Vec3.new(1.1, 2, 3)
      expect(v1.to_s).to eq("1.1 2 3")
    end
  end
end
