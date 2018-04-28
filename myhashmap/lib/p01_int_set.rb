class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num < @store.length && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)

    self[num] << num
  end

  def remove(num)
    bucket = num % num_buckets
    if include?(num)
      @store[bucket].delete(num)
    end
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].any? {|el| el==num }

  end

  private

  def [](num)
    bucket = num % num_buckets
    @store[bucket]
    # optional but useful; return the bucket corresponding to `num`
  end

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
    if @count == num_buckets
       resize!
    end

    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket = num % num_buckets
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

        bucket_idx = value % (num_buckets * 2)

        temp_store[bucket_idx] << value
      end
    end

    @store = temp_store
  end
end
