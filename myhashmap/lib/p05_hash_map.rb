require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    index = bucket(key)
    @store[index].include?(key)
  end

  def set(key, val)
    if @count == num_buckets
       resize!
    end
    index = bucket(key)
    if @store[index].include?(key)
      @store[index].update(key,val)
    else
      @store[index].append(key,val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
        list.each do |el|
          prc.call(el.key,el.val)
        end
    end
    @store
  end
  
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = Array.new(num_buckets * 2) {LinkedList.new}

    @store.each do |linked_list|
      linked_list.each do |list|

        bucket_idx = list.key.hash % (num_buckets * 2)

        temp_store[bucket_idx].append(list.key,list.val)
      end
    end

    @store = temp_store

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
