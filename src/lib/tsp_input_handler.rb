class TspInputHandler
  def self.get_matrix_from_user
    puts "TSP Solver - Enter Distance Matrix"
    puts "=================================="
    
    n = get_city_count
    puts "\nEnter the distance matrix (#{n}x#{n}):"
    puts "You can enter each row on a separate line, with distances separated by spaces."
    puts "Example for 3 cities: '0 10 20' for the first row"
    puts

    matrix = []
    (0...n).each do |i|
      row = get_matrix_row(i, n)
      matrix << row
    end

    [n, matrix]
  end

  def self.get_predefined_example
    puts "\nAvailable predefined examples:"
    puts "1. Small 3-city example"
    puts "2. Medium 4-city example"
    puts "3. Custom 5-city example"
    
    print "Choose an example (1-3): "
    choice = gets.chomp.to_i

    case choice
    when 1
      n = 3
      matrix = [
        [0, 29, 20],
        [29, 0, 15],
        [20, 15, 0]
      ]
    when 2
      n = 4
      matrix = [
        [0, 10, 15, 20],
        [10, 0, 35, 25],
        [15, 35, 0, 30],
        [20, 25, 30, 0]
      ]
    when 3
      n = 5
      matrix = [
        [0, 12, 10, 19, 8],
        [12, 0, 3, 7, 6],
        [10, 3, 0, 2, 20],
        [19, 7, 2, 0, 4],
        [8, 6, 20, 4, 0]
      ]
    else
      puts "Invalid choice, using default 3-city example"
      n = 3
      matrix = [
        [0, 29, 20],
        [29, 0, 15],
        [20, 15, 0]
      ]
    end

    puts "\nUsing matrix:"
    print_matrix(matrix)
    [n, matrix]
  end

  private

  def self.get_city_count
    loop do
      print "Enter the number of cities (minimum 2): "
      input = gets.chomp
      
      begin
        n = Integer(input)
        if n >= 2
          return n
        else
          puts "Error: Number of cities must be at least 2"
        end
      rescue ArgumentError
        puts "Error: Please enter a valid integer"
      end
    end
  end

  def self.get_matrix_row(row_index, n)
    loop do
      print "Row #{row_index + 1}: "
      input = gets.chomp.strip
      
      begin
        distances = input.split.map { |x| Integer(x) }
        
        if distances.length != n
          puts "Error: Expected #{n} distances, got #{distances.length}"
          next
        end

        # Negative distances
        negative_idx = distances.find_index { |d| d < 0 }
        if negative_idx
          puts "Error: Negative distance #{distances[negative_idx]} at column #{negative_idx + 1}"
          next
        end

        return distances
      rescue ArgumentError
        puts "Error: Please enter valid integers separated by spaces"
      end
    end
  end

  def self.print_matrix(matrix)
    matrix.each_with_index do |row, i|
      print "  [#{i}]: "
      puts row.join("\t")
    end
  end
end