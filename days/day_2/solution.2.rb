# Part 2

def policy(entry)
  # Pattern match each line to get useable data
  matcher = %r{(?<pos_1>\d+)-(?<pos_2>\d+)\s(?<target_char>[a-zA-Z]):\s(?<password>.+)}
  entry.match(matcher).named_captures.transform_keys(&:to_sym) # {:min=>"2", :max=>"9", :target_char=>"c", :password=>"ccccccccc"}
end

def conforms?(pos_1:, pos_2:, target_char:, password:)
  a, b =  [pos_1.to_i, pos_2.to_i].map { |i| password[i-1] }

  return false if a == b && a == target_char

  a == target_char || b == target_char
end

puts number_of_passwords_adherent = File.open("input.txt").readlines.count { |line| conforms?(**policy(line)) }

