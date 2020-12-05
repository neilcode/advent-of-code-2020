require 'rspec'
require_relative '../../days/day_5/solution.rb'

RSpec.describe Day5::Solution do
  describe 'seat location' do
    it 'example1' do
      expect(described_class.seat("BFFFBBFRRR")).to eq [70,7]
    end

    it 'example2' do
      expect(described_class.seat("FFFBBBFRRR")).to eq [14,7]
    end

    it 'example3' do
      expect(described_class.seat("BBFFBBFRLL")).to eq [102, 4]
    end
  end
end