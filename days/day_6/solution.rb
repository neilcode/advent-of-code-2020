require 'set'

module Day6
  module Solution
    module_function

    def solve_part_1(groups = input)
      groups.sum { |group| group.reduce(Set.new, &:merge).size }
    end

    def solve_part_2(groups = input)
      groups.sum { |group| group.map(&:to_set).reduce(&:intersection).size }
    end

    def prepare(file)
      file.split(/\n\n/).map do |group|
        group.split(/\n/).map(&:chars)
      end
    end
  end
end

# Day6::Solution.solve_part_1(
#   Day6::Solution.prepare(File.read("input.txt"))
# )  # => 6430
# Day6::Solution.solve_part_2(
#   Day6::Solution.prepare(File.read("input.txt"))
# )  # => 3125