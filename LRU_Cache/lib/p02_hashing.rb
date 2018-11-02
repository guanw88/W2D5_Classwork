class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    #good code, but reformatting for readability
    # self.map.with_index { |el, idx| el + idx }.reduce(:*).hash
    
    transformed_array = []
    
    self.each_with_index do |el, idx|
      transformed_array << (el + idx)
    end
    
    transformed_array.reduce(:*).hash 
  end
end

class String
  def hash
    
    alphabet = ("a".."z").to_a + ("A".."Z").to_a
    char_num_array = []
    
    self.split("").each do |letter|
      char_num_array << alphabet.index(letter) 
    end
    
    char_num_array.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
