require 'set'
module Day8
  module Solution
    module_function

    def solve_part_1(input)
      attempt_processing(input.split(/\n/))[:failed]
    end

    def attempt_processing(instructions, line: 0, global_acc: 0, processed: Set.new)
      return { failed: global_acc } unless processed.add?(line)
      return { success: global_acc } if line >= instructions.size
      begin
        operation, argument = parse_instruction(instructions[line])
      rescue => e
        raise [e.message, { line: line, processed: processed }].to_s
      end

      case operation
      when :acc
        attempt_processing(instructions, line: line + 1, global_acc: global_acc + argument, processed: processed)
      when :jmp
        attempt_processing(instructions, line: line + argument, global_acc: global_acc, processed: processed)
      when :nop
        attempt_processing(instructions, line: line + 1, global_acc: global_acc, processed: processed)
      end
    end

    def parse_instruction(s)
      op, val = s.split(" ")
      [op.to_sym, val.to_i]
    end

    def solve_part_2(input)
      instructions = input.split(/\n/)
      instructions.map.with_index { |x, idx| [idx, x] if x.start_with?("nop", "jmp") }
        .compact
        .each do |line, instruction|
          result = attempt_processing(insert_alternate_instruction(instructions.dup, line, instruction))
          break(result[:success]) if result[:success]
        end
    end

    def insert_alternate_instruction(instructions, line, instruction)
      instructions.tap do |i|
        i[line] = i[line].start_with?("nop") ? instruction.gsub("nop", "jmp") : instruction.gsub("jmp", "nop")
      end
    end
  end
end

# Day8::Solution.solve_part_1(File.read("input.txt"))  # => 1818
# Day8::Solution.solve_part_2(File.read("input.txt"))  # => 631