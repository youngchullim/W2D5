class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |el, i|
      temp = 0
      if el.is_a?(String)
        el.each_byte.with_index do |byte, j|
        temp += byte**(mod_power(i + j) + 5)
        end
      elsif el.is_a?(Integer) 
        temp = (el.hash % 128)**(mod_power(i) + 5)
      elsif el.is_a?(Array)
        temp = el.hash**(mod_power(i) + 5)
      end 
      total += temp
      temp = 0
    end
    total % 10_000_000
  end

  def mod_power(i)
    i % 10
  end
end

class String
  def hash
    self.chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
