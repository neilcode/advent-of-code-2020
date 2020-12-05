passports = File.read("input.txt").split("\n\n")

### Part 1
def passport_to_hash(str)
  str.split(/[\s|\n]/).map { |property| property.split(":") }.to_h.transform_keys(&:to_sym)
end

def validate_passport(passport, required: %i[ecl pid eyr hcl byr iyr hgt])
  (required - passport.keys).empty?
end

### Part 2
VALIDATIONS = {
  byr: ->(x) { x.to_i.between?(1920, 2002) },
  iyr: ->(x) { x.to_i.between?(2010, 2020) },
  eyr: ->(x) { x.to_i.between?(2020, 2030) },
  hcl: ->(x) { x.match(/\A#[0-9a-f]{6}\z/) },
  ecl: ->(x) { %w[amb blu brn gry grn hzl oth].include?(x) },
  pid: ->(x) { x.match(/\A\d{9}\z/) },
  hgt: ->(x) do
    return false unless match = x.match(/\A(\d+)(\w{2}\z)/)

    height, unit = match[1..2]
    case unit
    when "in" then height.to_i.between?(59, 76)
    when "cm" then height.to_i.between?(150, 193)
    end
  end
}

def valid_passport_data?(passport)
  VALIDATIONS.all? { |field, validator| validator.call(passport[field]) }
end

part_1_solution = passports.count { |p| validate_passport(passport_to_hash(p)) }  # => 264
part_2_solution = passports.map(&method(:passport_to_hash)).count { |p| validate_passport(p) && valid_passport_data?(p) }  # => 224