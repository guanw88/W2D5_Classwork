class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    return false if num < 0 || num >= @store.length
    true
  end

  # def validate!(num)
  # end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num unless include?(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    return true if @store[num % num_buckets].include?(num)
    false
  end

  private

  # def [](num)
  # end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    unless include?(num)
      @store[num % num_buckets] << num 
      @count += 1
    end 
  end

  def remove(num)
    item = @store[num % num_buckets].delete(num)
    @count -= 1 if item
  end

  def include?(num)
    return true if @store[num % num_buckets].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    store2 = Array.new(num_buckets * 2) { Array.new }
    
    @store.flatten.each do |el| 
      store2[el % (num_buckets * 2)] << el 
    end
    
    @store = store2
  end
end
