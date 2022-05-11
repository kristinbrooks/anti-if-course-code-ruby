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

  class AgedBrie
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality, @sell_in = quality, sell_in
    end

    def update
      if @quality < 50
        @quality = @quality + 1
      end
      @sell_in = @sell_in - 1
      if @sell_in < 0
        if @quality < 50
          @quality = @quality + 1
        end
      end
    end
  end

  class BackstagePass
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality, @sell_in = quality, sell_in
    end

    def update
      if @quality < 50
        @quality = @quality + 1
        if @sell_in < 11
          if @quality < 50
            @quality = @quality + 1
          end
        end
        if @sell_in < 6
          if @quality < 50
            @quality = @quality + 1
          end
        end
      end
      @sell_in = @sell_in - 1
      if @sell_in < 0
        @quality = @quality - @quality
      end
    end
  end

  class Sulfuras
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality, @sell_in = quality, sell_in
    end

    def update

    end
  end

  class GoodsCategory
    def build_for(item)
      if sulfuras?(item)
        Sulfuras.new(item.quality, item.sell_in)
      elsif generic?(item)
        Generic.new(item.quality, item.sell_in)
      elsif aged_brie?(item)
        AgedBrie.new(item.quality, item.sell_in)
      elsif backstage_pass?(item)
        BackstagePass.new(item.quality, item.sell_in)
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

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      goods = GoodsCategory.new.build_for(item)
      goods.update
      item.quality = goods.quality
      item.sell_in = goods.sell_in
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

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
