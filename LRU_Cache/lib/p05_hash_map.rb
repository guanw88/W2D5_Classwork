require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    
    resize! if @count == num_buckets
    
    list = bucket(key)
    
    if list.include?(key)
       list.update(key, val)
    else 
      list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    list = bucket(key)
    
    if list.include?(key)
      list.remove(key)
      @count -= 1 
    end
  end

  def each
    i = 0 
    while i < @store.length 
      @store[i].each do |node|
        yield([node.key, node.val])
      end 
      i += 1
    end
    
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    
    store2 = Array.new(num_buckets * 2) { LinkedList.new }
    
    @store.each do |list|
      list.each do |node|
        key = node.key 
        val = node.val
        store2[key.hash % (num_buckets * 2)].append(key, val)
      end
    end
    
    @store = store2
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
