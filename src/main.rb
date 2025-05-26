require_relative 'lib/tsp_calculate'
require_relative 'lib/tsp_input_handler'
require_relative 'lib/tsp_verifier'
require_relative 'test/test_tsp'

def main
  puts "Welcome to the TSP Solver use Dynamic Programming!"
  puts "=" * 50
  
  loop do
    puts "\nChoose an option:"
    puts "1. Solve TSP (manual input)"
    puts "2. Solve TSP (predefined examples)"
    puts "3. Verify a solution"
    puts "4. Manual calculation demo"
    puts "5. Run tests"
    puts "6. Performance test"
    puts "7. Exit"
    
    print "Your choice (1-7): "
    choice = gets.chomp
    
    case choice
    when '1'
      solve_with_manual_input
      
    when '2'
      solve_with_examples
      
    when '3'
      verify_solution
      
    when '4'
      manual_calculation_demo
      
    when '5'
      TspTest.run_all_tests
      
    when '6'
      TspTest.run_performance_test
      
    when '7'
      puts "Thank you for using TSP Solver!"
      break
      
    else
      puts "Invalid choice. Please enter 1-7."
    end
    
    unless choice == '7'
      print "\nPress Enter to continue..."
      gets
    end
  end
end

def solve_with_manual_input
  begin
    n, matrix = TspInputHandler.get_matrix_from_user
    puts "\nSolving TSP..."
    result = TspCalculate.solve(n, matrix)
    puts "\nResult:"
    puts result
  rescue TspError => e
    puts "\nError: #{e.message}"
  rescue Interrupt
    puts "\n\nOperation cancelled by user."
  end
end

def solve_with_examples
  begin
    n, matrix = TspInputHandler.get_predefined_example
    puts "\nSolving TSP..."
    result = TspCalculate.solve(n, matrix)
    puts "\nResult:"
    puts result
  rescue TspError => e
    puts "\nError: #{e.message}"
  end
end

def verify_solution
  puts "\nSolution Verification"
  puts "=" * 25
  
  begin
    print "Number of cities: "
    n = Integer(gets.chomp)
    
    puts "Enter distance matrix (#{n} rows, space-separated):"
    matrix = []
    (0...n).each do |i|
      print "Row #{i}: "
      row = gets.chomp.split.map { |x| Integer(x) }
      matrix << row
    end
    
    print "Enter solution path (space-separated cities): "
    path = gets.chomp.split.map { |x| Integer(x) }
    
    TspVerifier.verify_solution(matrix, path)
    
  rescue ArgumentError
    puts "Error: Please enter valid integers"
  rescue => e
    puts "Error: #{e.message}"
  end
end

def manual_calculation_demo
  puts "\nManual Calculation Demo"
  puts "=" * 25
  
  # Coba demo
  matrix = [
    [0, 29, 20],
    [29, 0, 15],
    [20, 15, 0]
  ]
  path = [0, 2, 1, 0]
  
  TspVerifier.manual_calculation_step_by_step(matrix, path)
  
  puts "\nVerifying this is optimal:"
  TspVerifier.verify_solution(matrix, path)
end

# Entry point
if __FILE__ == $0
  if ARGV.include?('--test')
    TspTest.run_all_tests
    TspTest.run_performance_test if ARGV.include?('--performance')
  else
    main
  end
end