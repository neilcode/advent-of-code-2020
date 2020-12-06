require 'rspec'
require_relative '../../days/day_6/solution.rb'

RSpec.describe Day6::Solution do

  it 'part_1 example' do
    expect(
      Day6::Solution.solve_part_1(
        [
          [%w[a b c], %w[a d]], # 4 uniques
          [%w[x y z], %w[w t f]] # 6 uniques
        ]
      )
    ).to eq 10
  end

  it 'part_2 example' do
    expect(
      Day6::Solution.solve_part_2(
        [
          [%w[a b c], %w[a d]], # 1 shared
          [%w[x y z], %w[w t f]] # 0 shared
        ]
      )
    ).to eq 1
  end
end