class Item {
  constructor(name, sellIn, quality) {
    this.name = name;
    this.sellIn = sellIn;
    this.quality = quality;
  }
}

class Shop {
  constructor(items = []) {
    this.items = items;
  }
  updateQuality() {
    for (var i = 0; i < this.items.length; i++) {
      this.update(i);
      if (this.items[i].name.includes("Conjured")) {
        this.update(i);
      }
    }
    return this.items;
  }

  update(i) {
    if (
      !this.items[i].name.includes("Aged Brie") &&
      !this.items[i].name.includes("Backstage passes to a TAFKAL80ETC concert")
    ) {
      if (this.items[i].quality > 0) {
        if (!this.items[i].name.includes("Sulfuras, Hand of Ragnaros")) {
          this.items[i].quality = this.items[i].quality - 1;
        }
      }
    } else {
      if (this.items[i].quality < 50) {
        this.items[i].quality = this.items[i].quality + 1;
        if (
          this.items[i].name.includes(
            "Backstage passes to a TAFKAL80ETC concert"
          )
        ) {
          if (this.items[i].sellIn < 11) {
            if (this.items[i].quality < 50) {
              this.items[i].quality = this.items[i].quality + 1;
            }
          }
          if (this.items[i].sellIn < 6) {
            if (this.items[i].quality < 50) {
              this.items[i].quality = this.items[i].quality + 1;
            }
          }
        }
      }
    }
    if (!this.items[i].name.includes("Sulfuras, Hand of Ragnaros")) {
      this.items[i].sellIn = this.items[i].sellIn - 1;
    }
    if (this.items[i].sellIn < 0) {
      if (!this.items[i].name.includes("Aged Brie")) {
        if (
          !this.items[i].name.includes(
            "Backstage passes to a TAFKAL80ETC concert"
          )
        ) {
          if (this.items[i].quality > 0) {
            if (!this.items[i].name.includes("Sulfuras, Hand of Ragnaros")) {
              this.items[i].quality = this.items[i].quality - 1;
            }
          }
        } else {
          this.items[i].quality = this.items[i].quality - this.items[i].quality;
        }
      } else {
        if (this.items[i].quality < 50) {
          this.items[i].quality = this.items[i].quality + 1;
        }
      }
    }
  }
}
module.exports = {
  Item,
  Shop,
};
