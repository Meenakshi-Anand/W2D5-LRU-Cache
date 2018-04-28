class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 0

    self.each_with_index do |el,idx|
      # el = el.to_s
      hash_value += el.hash
      hash_value *= idx + 1
    end

    hash_value = hash_value.to_i * 13
    hash = hash_value * length
    hash % 10000000000000000
  end
end

class String
  def hash

    hash_value = 987
    self.each_char.with_index do |el, idx|
      hash_value += el.ord
      hash_value *= (idx + 1)
      hash_value *= length * 7 * 13

    end

    hash_value *= length * 7 * 13
    hash_value % 10000000000000000
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_arr = self.sort_by {|k,v| v}

    hash_arr << "i'm a hash"

    hash_arr.hash
  end
end
