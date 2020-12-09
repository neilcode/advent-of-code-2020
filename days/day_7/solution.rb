require 'set'
module Day7
  module Solution
    module_function

    def solve_part_1(input)
      outer_most_bags(input).size
    end

    def outer_most_bags(bag_definitions, possible_holders: Set.new, target_bag: "shiny gold")
      bags_that_hold(bag_definitions, target_bag).map do |surrounding_bag|
        outer_most_bags(
          bag_definitions,
          possible_holders: possible_holders << surrounding_bag,
          target_bag: surrounding_bag
        )
      end

      possible_holders
    end

    def bags_that_hold(bag_definitions, bag_type)
      bag_definitions.scan(%r{^.+ contain .+#{bag_type}.+$}).map do |bag_def|
        bag_def.split(/\sbags contain\s/).first
      end
    end

    def solve_part_2(input)
      bags_inside(input)
    end

    def bags_inside(bag_definitions, target_bag: "shiny gold")
      inner_bags = bags_held_by(bag_definitions, target_bag)
      return 0 if inner_bags == :none

      bags_in_this_bag = inner_bags.map { |n, _bag| n}.sum
      bags_in_this_bag + inner_bags.map { |n, bag| n * bags_inside(bag_definitions, target_bag: bag) }.sum
    end

    def bags_held_by(bag_definitions, bag)
      bag_description = bag_definitions.scan(%r{^#{bag} bags contain .+$}).first
      bag_type, contains = bag_description.split /\sbags contain\s/
      return :none if contains == "no other bags."

      contains.split(",").map do |description|
        m = /(?<amount>\d+) (?<type>\w+ \w+) bag.?/.match(description)
        [m[:amount].to_i,  m[:type]]
      end
    end
  end
end

# Day7::Solution.solve_part_1(File.read("input.txt"))  #==> 161
# Day7::Solution.solve_part_2(File.read("input.txt"))  #==> 30899