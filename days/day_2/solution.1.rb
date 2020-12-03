# Part 1
#
def policy(entry)
  # Pattern match each line to get useable data
  matcher = %r{(?<min>\d+)-(?<max>\d+)\s(?<target_char>[a-zA-Z]):\s(?<password>.+)}
  entry.match(matcher).named_captures.transform_keys(&:to_sym) # {:min=>"2", :max=>"9", :target_char=>"c", :password=>"ccccccccc"}
end

def conforms?(min:, max:, target_char:, password:)
  character_frequencies(password).fetch(target_char, 0).between?(min.to_i, max.to_i)
end

def character_frequencies(str)
  str.chars.each_with_object(Hash.new(0)) { |char, freq| freq[char] += 1 }
end

number_of_passwords_adherent = File.open("input.txt").split("\n").count { |line| conforms?(**policy(line)) }

# Part 2

def policy(entry)
  # Pattern match each line to get useable data
  matcher = %r{(?<min>\d+)-(?<max>\d+)\s(?<target_char>[a-zA-Z]):\s(?<password>.+)}
  entry.match(matcher).named_captures.transform_keys(&:to_sym) # {:min=>"2", :max=>"9", :target_char=>"c", :password=>"ccccccccc"}
end


