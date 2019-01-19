class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(value)
    if @count >= num_buckets
      @count = 0
      resize! 
    end
    unless include?(value)
      self[value.hash] << value 
      @count += 1
    end
  end

  def remove(value)
    @count -= 1 if self[value.hash].delete(value)
  end

  def include?(value)
    self[value.hash].include?(value)
  end

  private
  attr_accessor :store
  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(num_buckets*2) {Array.new}
    old_store.each do |bucket|
      bucket.each do |el|
        insert(el)
      end 
    end 
  end 
end
