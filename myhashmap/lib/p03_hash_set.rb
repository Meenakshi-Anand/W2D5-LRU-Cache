require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == num_buckets
       resize!
    end

    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    bucket = num.hash % num_buckets
    @store[bucket]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = Array.new(num_buckets * 2) { Array.new }

    @store.each do |bucket|
      bucket.each do |value|

        bucket_idx = value.hash % (num_buckets * 2)

        temp_store[bucket_idx] << value
      end
    end

    @store = temp_store
  end
end
