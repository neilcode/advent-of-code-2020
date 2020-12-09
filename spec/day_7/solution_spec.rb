require 'pry'
require 'rspec'
require_relative '../../days/day_7/solution.rb'

RSpec.describe Day7::Solution do
  let(:test_input) do
    <<~BAGS
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    BAGS
  end

  describe ".number_of_bags_inside" do
    let(:extra_test) do
      <<~BAGS
        shiny gold bags contain 2 dark red bags.
        dark red bags contain 2 dark orange bags.
        dark orange bags contain 2 dark yellow bags.
        dark yellow bags contain 2 dark green bags.
        dark green bags contain 2 dark blue bags.
        dark blue bags contain 2 dark violet bags.
        dark violet bags contain no other bags.
      BAGS
    end

    it "returns count of bags inside given bag" do
      expect(described_class.bags_inside(test_input)).to eq(32)
    end

    it "works real well" do
      expect(described_class.bags_inside(extra_test)).to eq(126)
    end

    it "returns 0 if the bag contains no other bags" do
      expect(described_class.bags_inside(
        "faded blue bags contain no other bags.",
        target_bag: "faded blue"
      )).to eq(0)
    end
  end


  describe ".bags_that_hold" do
    it "finds all bag descriptions that contain a specific bag" do
      expect(described_class.bags_that_hold(test_input, "shiny gold")).to eq(["bright white","muted yellow"])
    end
  end

  describe ".find_bag_dependencies" do
    it "finds outer bags" do
      expect(described_class.outer_most_bags(test_input)).to eq(
        Set.new(["bright white", "muted yellow", "dark orange", "light red"])
      )
    end
  end
end