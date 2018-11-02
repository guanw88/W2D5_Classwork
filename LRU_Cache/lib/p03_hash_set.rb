class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == @store.length
    unless include?(key)
      self[key] << key
      @count += 1
    end 
  end

  def include?(key)
    return true if self[key].include?(key)
    false
  end

  def remove(key)
     if include?(key)
       self[key].delete(key)
       @count -= 1
     end 
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store2 = Array.new(num_buckets * 2) { Array.new }
    @store.flatten.each do |key|
      store2[key.hash % store2.length] << key
    end 
    @store = store2  
  end
  
end
