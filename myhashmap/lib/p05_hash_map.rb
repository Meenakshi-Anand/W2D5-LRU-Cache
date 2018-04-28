require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end
  #
  def include?(key)
    bucket = bucket(key)
    @store[bucket]
    @store[bucket].include?(key)
  end
  #
  def set(key, val)
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key,val)
    else
      @store[bucket(key)].append(key,val)
    end
     @store[bucket(key)]
  end

  def get(key)

    @store[bucket(key)].include?(key)
  end
  #
  # def delete(key)
  # end
  #
  # def each
  # end

  # def insert(key)
  #   if @count == num_buckets
  #      resize!
  #   end
  #
  #   unless include?(key)
  #     self[key] << key
  #     @count += 1
  #   end
  # end


  def delete(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
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
  end

  def bucket(key)
    bucket = key.hash % num_buckets
    # optional but useful; return the bucket corresponding to `key`
  end
end
