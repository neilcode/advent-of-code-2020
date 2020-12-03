TREE = "#"
Position = Struct.new(:x, :y) do
  def +(other)
    Position.new(self.x + other.x, self.y + other.y)
  end
end

def look_at(terrain, position)
  line = terrain[position.y]
  return :out_of_bounds unless line

  # handle repeating nature of terrain
  pattern_width = line.size
  if position.x >= pattern_width
    line.at(position.x % pattern_width)
  else
    line.at(position.x)
  end
end

def traverse(terrain:, slope:, current_pos: Position.new(0,0), trees: [])
  ground = look_at(terrain, current_pos)
  return trees if ground == :out_of_bounds
  trees << current_pos if ground == TREE

  traverse(
    terrain: terrain,
    slope: slope,
    current_pos: current_pos + slope,
    trees: trees
  )
end

terrain = File.read("input.txt").split("\n").map(&:chars)

### part 2
slopes = [
  Position.new(1,1),
  Position.new(3,1),
  Position.new(5,1),
  Position.new(7,1),
  Position.new(1,2)
]

slopes.map { |slope|  traverse(terrain: terrain, slope: slope).count }.reduce(:*)  # => 6818112000

