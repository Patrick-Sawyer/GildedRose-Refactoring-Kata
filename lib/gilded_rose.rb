# frozen_string_literal: true

class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1
      update(item)
      update(item) if item.name.include?("Conjured")
    end
  end

  def update(item)
    degrade(item) 
    degrade(item) if item.sell_in < 0 
  end

  def degrade(item)
    case 
    when item.name.include?("Backstage passes")
      backstage(item)
    when item.name.include?("Aged Brie")
      item.quality += 1
    when item.name.include?("Sulfuras")
      item.sell_in = 10
    else
      item.quality -= 1
    end
    item.quality = 50 if item.quality > 50
  end

  def backstage(item)
    item.quality += 1
    (item.quality += 1) if (item.sell_in < 10)
    (item.quality += 1) if (item.sell_in < 5)
    (item.quality = 0) if (item.sell_in < 0)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
