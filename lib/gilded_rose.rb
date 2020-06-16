# frozen_string_literal: true

class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      # run update method as it was before

      update(item)
      next unless item.name.include? 'Conjured'

      # if it is conjured run it again, but add another day to sell_in first
      # dont change the sell_in if Sulfuras

      item.sell_in += 1 unless item.name.include? 'Sulfuras, Hand of Ragnaros'
      update(item)
    end
  end

  def update(item)
    if (!item.name.include? 'Aged Brie') && (!item.name.include? 'Backstage passes to a TAFKAL80ETC concert')
      if item.quality > 0
        item.quality = item.quality - 1 unless item.name.include? 'Sulfuras, Hand of Ragnaros'
      end
    else
      if item.quality < 50
        item.quality = item.quality + 1
        if item.name.include? 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            item.quality = item.quality + 1 if item.quality < 50
          end
          if item.sell_in < 6
            item.quality = item.quality + 1 if item.quality < 50
          end
        end
      end
    end
    item.sell_in = item.sell_in - 1 unless item.name.include? 'Sulfuras, Hand of Ragnaros'
    if item.sell_in < 0
      if !item.name.include? 'Aged Brie'
        if !item.name.include? 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > 0
            item.quality = item.quality - 1 unless item.name.include? 'Sulfuras, Hand of Ragnaros'
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        item.quality = item.quality + 1 if item.quality < 50
      end
    end
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
