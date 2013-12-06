class Item
  attr_reader :initial_sell_in, :initial_quality
  attr_accessor :sell_in, :quality
  def initialize(name, initial_sell_in, initial_quality)
    @initial_sell_in = initial_sell_in
    @initial_quality = initial_quality
    @sell_in = @initial_sell_in
    @quality = @initial_quality
  end

end  

class BaseItem
  attr_reader :item
  def initialize(item)
    @item = item
  end
  
  def one_of?(item)
    false
  end
end

class WorthlessItem < BaseItem
  def update_quality
  end
  
  def self.one_of?(item)
    item.quality <= 0
  end

end

class ExpiredItem < BaseItem
  def update_quality
    item.quality -= 2
  end
  
  def self.one_of?(item)
    item.sell_in <= 0
  end

end

class RegularItem < BaseItem
  def update_quality
    item.quality -= 1 
  end
  
  def self.one_of?(item)
    true
  end
end

def item_factory(item)
  [ExpiredItem, WorthlessItem, RegularItem].each do |item_class|
    if (item_class.one_of?(item))
      return item_class.new(item)
    end    
  end
end

def update_quality(items)
  items.each do |item|
    item_updater = item_factory(item)
    item_updater.update_quality
    item.sell_in -= 1
  end
end

