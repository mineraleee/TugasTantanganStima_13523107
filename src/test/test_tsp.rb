require_relative '../lib/tsp_calculate'
require_relative '../lib/tsp_verifier'

class TspTest
  def self.run_all_tests
    puts "Running TSP Solver Tests..."
    puts "=" * 30
    
    test_count = 0
    passed_count = 0

    # Test 1: Valid small graph
    test_count += 1
    begin
      matrix = [
        [0, 10, 15, 20],
        [10, 0, 35, 25],
        [15, 35, 0, 30],
        [20, 25, 30, 0]
      ]
      result = TspCalculate.solve(4, matrix)
      if result.min_cost == 80 && result.optimal_path == [0, 1, 3, 2, 0]
        puts "✓ Test 1 (Valid 4-city graph): PASSED"
        passed_count += 1
      else
        puts "✗ Test 1 (Valid 4-city graph): FAILED"
        puts "  Expected: cost=80, path=[0,1,3,2,0]"
        puts "  Got: cost=#{result.min_cost}, path=#{result.optimal_path}"
      end
    rescue => e
      puts "✗ Test 1 (Valid 4-city graph): FAILED with exception: #{e.message}"
    end

    # Test 2: 3 kota
    test_count += 1
    begin
      matrix = [
        [0, 29, 20],
        [29, 0, 15],
        [20, 15, 0]
      ]
      result = TspCalculate.solve(3, matrix)
      if result.min_cost == 64 && result.optimal_path == [0, 2, 1, 0]
        puts "✓ Test 2 (3-city graph): PASSED"
        passed_count += 1
      else
        puts "✗ Test 2 (3-city graph): FAILED"
        puts "  Expected: cost=64, path=[0,2,1,0]"
        puts "  Got: cost=#{result.min_cost}, path=#{result.optimal_path}"
      end
    rescue => e
      puts "✗ Test 2 (3-city graph): FAILED with exception: #{e.message}"
    end

    # Test 3: 2 kota
    test_count += 1
    begin
      matrix = [
        [0, 5],
        [5, 0]
      ]
      result = TspCalculate.solve(2, matrix)
      if result.min_cost == 10 && result.optimal_path == [0, 1, 0]
        puts "✓ Test 3 (2-city graph): PASSED"
        passed_count += 1
      else
        puts "✗ Test 3 (2-city graph): FAILED"
        puts "  Expected: cost=10, path=[0,1,0]"
        puts "  Got: cost=#{result.min_cost}, path=#{result.optimal_path}"
      end
    rescue => e
      puts "✗ Test 3 (2-city graph): FAILED with exception: #{e.message}"
    end

    # Test 4: Invalid jumlah city
    test_count += 1
    begin
      TspCalculate.solve(1, [[0]])
      puts "✗ Test 4 (Invalid city count): FAILED - Should raise error"
    rescue TspError => e
      if e.type == :invalid_city_count
        puts "✓ Test 4 (Invalid city count): PASSED"
        passed_count += 1
      else
        puts "✗ Test 4 (Invalid city count): FAILED - Wrong error type: #{e.type}"
      end
    rescue => e
      puts "✗ Test 4 (Invalid city count): FAILED with unexpected exception: #{e.message}"
    end

    # Test 5: Negative distance
    test_count += 1
    begin
      matrix = [
        [0, -5, 15],
        [10, 0, 25],
        [20, 25, 0]
      ]
      TspCalculate.solve(3, matrix)
      puts "✗ Test 5 (Negative distance): FAILED - Should raise error"
    rescue TspError => e
      if e.type == :negative_distance
        puts "✓ Test 5 (Negative distance): PASSED"
        passed_count += 1
      else
        puts "✗ Test 5 (Negative distance): FAILED - Wrong error type: #{e.type}"
      end
    rescue => e
      puts "✗ Test 5 (Negative distance): FAILED with unexpected exception: #{e.message}"
    end

    # Test 6: Path validation
    test_count += 1
    begin
      errors = TspCalculate.validate_path([0, 1, 2, 0], 3)
      if errors.empty?
        puts "✓ Test 6 (Path validation - valid): PASSED"
        passed_count += 1
      else
        puts "✗ Test 6 (Path validation - valid): FAILED - Should have no errors"
      end
    rescue => e
      puts "✗ Test 6 (Path validation - valid): FAILED with exception: #{e.message}"
    end

    # Test 7: Cost calculation
    test_count += 1
    begin
      matrix = [
        [0, 10, 20],
        [10, 0, 15],
        [20, 15, 0]
      ]
      cost = TspCalculate.calculate_path_cost(matrix, [0, 1, 2, 0])
      expected_cost = 10 + 15 + 20 # 0->1 + 1->2 + 2->0
      if cost == expected_cost
        puts "✓ Test 7 (Cost calculation): PASSED"
        passed_count += 1
      else
        puts "✗ Test 7 (Cost calculation): FAILED"
        puts "  Expected: #{expected_cost}, Got: #{cost}"
      end
    rescue => e
      puts "✗ Test 7 (Cost calculation): FAILED with exception: #{e.message}"
    end

    # Test 8: Verification function
    test_count += 1
    begin
      matrix = [
        [0, 29, 20],
        [29, 0, 15],
        [20, 15, 0]
      ]
      verification = TspVerifier.verify_solution(matrix, [0, 2, 1, 0], verbose: false)
      if verification[:is_optimal] && verification[:solution_cost] == 64
        puts "✓ Test 8 (Solution verification): PASSED"
        passed_count += 1
      else
        puts "✗ Test 8 (Solution verification): FAILED"
        puts "  Expected: optimal=true, cost=64"
        puts "  Got: optimal=#{verification[:is_optimal]}, cost=#{verification[:solution_cost]}"
      end
    rescue => e
      puts "✗ Test 8 (Solution verification): FAILED with exception: #{e.message}"
    end

    puts "\nTest Results: #{passed_count}/#{test_count} passed"
    if passed_count == test_count
      puts "All tests passed yeay^^!"
    else
      puts "#{test_count - passed_count} test(s) failed"
    end
    puts "=" * 40
    
    passed_count == test_count
  end

  def self.run_performance_test
    puts "\nPerformance Test"
    puts "=" * 20
    
    sizes = [3, 4, 5, 6, 7]
    
    sizes.each do |n|
      # Generate random symmetric matrix
      matrix = Array.new(n) { Array.new(n, 0) }
      (0...n).each do |i|
        (i+1...n).each do |j|
          distance = rand(10..50)
          matrix[i][j] = distance
          matrix[j][i] = distance
        end
      end
      
      # Check waktu
      start_time = Time.now
      result = TspCalculate.solve(n, matrix)
      end_time = Time.now
      
      elapsed = ((end_time - start_time) * 1000).round(2)
      puts "#{n} cities: #{elapsed}ms (cost: #{result.min_cost})"
    end
  end
end