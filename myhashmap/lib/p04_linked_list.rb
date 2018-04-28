require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

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
    @prev.next = @next
    @next.prev = @prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
  def inspect
    "Next.val #{@next},#{@next.val}"
  end
end

class LinkedList

include Enumerable

  def initialize
    @head = Node.new()
    @tail = Node.new()
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
    first == @tail && last == @head
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end

    nil
  end

  def include?(key)

    each do |node|
      return true if node.key == key
    end

    false
  end

  def append(key, val)

    node = Node.new(key,val)
    previous = @tail.prev

    node.next,node.prev = @tail,@tail.prev
    @tail.prev, previous.next = node , node
  end

  def update(key, val)
    if include?(key)
      # remove(key)
      #
      # node = Node.new(key,val)
      # next_node = @head.next
      #
      # node.prev, node.next = @head, @head.next
      # @head.next, next_node.next = node, node

      self.each do |node|
        node.val = val if node.key == key
      end
    end
  end

  def remove(key)
    unless empty?

      self.each do |node|
        if node.key == key
          node.remove
        end
      end
    end
  end

  def each(&prc)
    index = @head.next

    until index == @tail
      prc.call(index)

      index = index.next
    end

    self
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  def inspect
    "Head :#{@head}"
  end


end
