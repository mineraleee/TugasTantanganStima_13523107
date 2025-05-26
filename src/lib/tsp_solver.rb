require_relative 'tsp_error'
require_relative 'tsp_result'

# Menggunakan dp -> dynamic programming
# n= jumlah kota ; dist = jarak; memo = simpan hasil perhitungan DP
class TspSolver
  def initialize(n, distance_matrix)
    @n = n
    @dist = distance_matrix
    @memo = {}
    validate_input
  end

  def solve
    @memo.clear
    
    # Dimulai dari kota 0, visit seluruh kota lainnya (direpresent by bitmask)
    start_mask = 1 # Kota 0 dikunjungi
    
    min_cost, _ = dp(0, start_mask)
    optimal_path = reconstruct_path
    
    TspResult.new(min_cost, optimal_path)
  end

  private

  def validate_input
    # Validasi jumlah city
    if @n < 2
      raise TspError.new(:invalid_city_count, count: @n)
    end

    # Validasi dimensi matrix
    if @dist.length != @n
      raise TspError.new(:invalid_matrix_size, 
                        expected: @n, 
                        actual: @dist.length)
    end

    @dist.each_with_index do |row, row_idx|
      if row.length != @n
        raise TspError.new(:non_square_matrix)
      end
      
      # Check for negative distances
      row.each_with_index do |distance, col_idx|
        if distance < 0
          raise TspError.new(:negative_distance,
                            row: row_idx,
                            col: col_idx,
                            distance: distance)
        end
      end
    end
  end

  # pos --> posisi kota saat ini
  # mask --> bitmask (contoh: 01101 artinya udah mengunjungi kota 0, 2, dan 3))
  def dp(pos, mask)
    # Kalau udah semua kota, kembali ke starting city
    if mask == (1 << @n) - 1
      return [@dist[pos][0], 0]
    end

    # Cek memoization
    key = [pos, mask]
    return @memo[key] if @memo.key?(key)

    min_cost = Float::INFINITY
    best_next = 0

    # Visit setiap city yang belum, hitung biaya lalu simpan rute
    (0...@n).each do |next_city|
      next if mask & (1 << next_city) != 0

      new_mask = mask | (1 << next_city)
      cost, _ = dp(next_city, new_mask)
      
      next if cost == Float::INFINITY

      total_cost = @dist[pos][next_city] + cost
      if total_cost < min_cost
        min_cost = total_cost
        best_next = next_city
      end
    end

    result = [min_cost, best_next]
    @memo[key] = result
    result
  end

  def reconstruct_path
    path = [0]
    pos = 0
    mask = 1

    while mask != (1 << @n) - 1
      key = [pos, mask]
      if @memo.key?(key)
        _, next_city = @memo[key]
        path << next_city
        mask |= 1 << next_city
        pos = next_city
      else
        break
      end
    end
    
    path << 0 # Kembali ke start
    path
  end
end