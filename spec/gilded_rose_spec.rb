# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
    describe 'non conjured' do
      it 'takes 1 off sell_in and quality when non conjured, and not special' do
        items = [Item.new('foo', 10, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].sell_in).to eq 9
        expect(subject.items[0].quality).to eq 9
      end

      it 'degrades twice as fast after sell by date' do
        items = [Item.new('foo', 0, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].sell_in).to eq(-1)
        expect(subject.items[0].quality).to eq(8)
      end

      it 'adds one on to quality of brie' do
        items = [Item.new('Aged Brie', 10, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].sell_in).to eq 9
        expect(subject.items[0].quality).to eq 11
      end

      it 'cannot raise quality above 50' do
        items = [Item.new('Aged Brie', 10, 49)]
        subject = GildedRose.new(items)
        subject.update_quality
        subject.update_quality
        expect(subject.items[0].quality).to eq 50
      end

      it 'keeps values the same when sulfuras' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 10, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].quality).to eq 10
        expect(subject.items[0].sell_in).to eq 10
      end

      it 'correct number of quality points when backstage pass' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 10)]
        subject = GildedRose.new(items)
        subject.update_quality # 10 days
        expect(subject.items[0].quality).to eq 11
        subject.update_quality # 9
        subject.update_quality # 8
        expect(subject.items[0].quality).to eq 15
        subject.update_quality # 7
        subject.update_quality # 6
        expect(subject.items[0].quality).to eq 19
        subject.update_quality # 5
        expect(subject.items[0].quality).to eq 21
        subject.update_quality # 4
        expect(subject.items[0].quality).to eq 24
        subject.update_quality # 3
        expect(subject.items[0].quality).to eq 27
        subject.update_quality # 2
        expect(subject.items[0].quality).to eq 30
        subject.update_quality # 1
        expect(subject.items[0].quality).to eq 33
        subject.update_quality # 0
        expect(subject.items[0].quality).to eq 36
        subject.update_quality # -1
        expect(subject.items[0].quality).to eq 0
      end
    end

    describe 'conjured' do
      it 'takes 2 off quality when conjured, and not special' do
        items = [Item.new('Conjured foo', 10, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].sell_in).to eq 9
        expect(subject.items[0].quality).to eq 8
      end

      it 'degrades twice as fast after sell by date' do
        items = [Item.new('Conjured foo', 0, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].sell_in).to eq(-1)
        expect(subject.items[0].quality).to eq(6)
      end

      it 'adds two on to quality of conjured brie' do
        items = [Item.new('Conjured Aged Brie', 10, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].sell_in).to eq 9
        expect(subject.items[0].quality).to eq 12
      end

      it 'cannot raise quality above 50' do
        items = [Item.new('Conjured Aged Brie', 10, 47)]
        subject = GildedRose.new(items)
        subject.update_quality
        subject.update_quality
        expect(subject.items[0].quality).to eq 50
      end

      it 'keeps values the same when conjured sulfuras' do
        items = [Item.new('Conjured Sulfuras, Hand of Ragnaros', 10, 10)]
        subject = GildedRose.new(items)
        subject.update_quality
        expect(subject.items[0].quality).to eq 10
        expect(subject.items[0].sell_in).to eq 10
      end

      it 'correct number of quality points when conjured backstage pass' do
        items = [Item.new('Conjured Backstage passes to a TAFKAL80ETC concert', 11, 0)]
        subject = GildedRose.new(items)
        subject.update_quality # 10 days
        expect(subject.items[0].quality).to eq 2
        subject.update_quality # 9
        subject.update_quality # 8
        expect(subject.items[0].quality).to eq 10
        subject.update_quality # 7
        subject.update_quality # 6
        expect(subject.items[0].quality).to eq 18
        subject.update_quality # 5
        expect(subject.items[0].quality).to eq 22
        subject.update_quality # 4
        expect(subject.items[0].quality).to eq 28
        subject.update_quality # 3
        expect(subject.items[0].quality).to eq 34
        subject.update_quality # 2
        expect(subject.items[0].quality).to eq 40
        subject.update_quality # 1
        expect(subject.items[0].quality).to eq 46
        subject.update_quality # 0
        expect(subject.items[0].quality).to eq 50
        subject.update_quality # -1
        expect(subject.items[0].quality).to eq 0
      end
    end
  end
end
