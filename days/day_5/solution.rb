# Monkey patching isn't cheating when the standard
# library should have it in the first place
class Array
  def split_at(idx)
    [self[0...idx], self[idx..-1]]
  end
end

module Day5
  module Solution
    ROWS = (0..127).to_a
    COLS = (0..7).to_a
    module_function

    def input
      File.read("./input.txt").split /\n/
    end

    def seat(partitions)
      row_parts, col_parts = partitions.chars.split_at(7)

      partition_repeatedly(ROWS, row_parts) + partition_repeatedly(COLS, col_parts)
    end

    def partition_repeatedly(seats, partitions)
      partitions.reduce(seats) do |seats, part|
        case part
        when "F", "L"
          seats.split_at(seats.count / 2).first
        when "B", "R"
          seats.split_at(seats.count / 2).last
        end
      end
    end

    def seat_id(row, col)
      (row * 8) + col
    end

    def solve_part_1
      input.map { |boarding_pass| seat_id(*seat(boarding_pass)) }.max
    end

    def solve_part_2
      seat_ids = []
      input.each { |boarding_pass| seat_ids[seat_id(*seat(boarding_pass))] = :person }.max
      seat_ids.find.with_index do |seat, idx|
        next unless seat.nil? && seat_ids[idx-1] == :person && seat_ids[idx+1] == :person
        break(idx)
      end
    end
  end
end
