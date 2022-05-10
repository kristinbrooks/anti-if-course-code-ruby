class GildedRose

  class Generic
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality, @sell_in = quality, sell_in
    end

    def update
      if @quality > 0
        @quality = @quality - 1
      end
      @sell_in = @sell_in - 1
      if @sell_in < 0
        if @quality > 0
          @quality = @quality - 1
        end
      end
    end

  end

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if sulfuras?(item)
      elsif generic?(item)
        generic = Generic.new(item.quality, item.sell_in)
        generic.update
        item.quality = generic.quality
        item.sell_in = generic.sell_in
      elsif aged_brie?(item)
        if item.quality < 50
          item.quality = item.quality + 1
        end
        item.sell_in = item.sell_in - 1
        if item.sell_in < 0
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      elsif backstage_pass?(item)
        if item.quality < 50
          item.quality = item.quality + 1
          if item.sell_in < 11
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
        end
        item.sell_in = item.sell_in - 1
        if item.sell_in < 0
          item.quality = item.quality - item.quality
        end
      end
    end
  end

  private

  def generic?(item)
    ! (sulfuras?(item) or backstage_pass?(item) or aged_brie?(item))
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
