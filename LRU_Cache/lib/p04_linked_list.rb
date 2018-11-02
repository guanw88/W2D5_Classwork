class Node
  
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    previous_node = self.prev 
    next_node = self.next
    #re-assigns previous and next to bypass current node
    previous_node.next = next_node 
    next_node.prev = previous_node
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail 
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end 
    
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    
    last.next = new_node #update last
    
    new_node.prev = last #update new node
    new_node.next = @tail 
    
    @tail.prev = new_node #update tail 
  end

  def update(key, val)
    
    self.each do |node|
      node.val = val if node.key == key
    end
    
  end

  def remove(key)
    current_node = nil
    self.each do |node|
      if node.key == key
        node.remove
        break
      end 
    end
  end

  def each
    current_node = first 
    
    until current_node == @tail
      yield(current_node)
      current_node = current_node.next
    end 

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
