class Store
  attr_reader :width, :height
  def initialize(x, y)
    @width = x.to_i
    @height = y.to_i
    @arr = Array.new(@height) { |i| Array.new(@width) {'-'} }
  end

  def store(posX, posY, width, height, type)
    # total_width = @arr.size
    # total_height = @arr[0].size

    posX = posX.to_i
    posY = posY.to_i
    width = width.to_i
    height = height.to_i

    # error handling

    products_to_store = []
    (posY..posY+height-1).each do |_posy|
      (posX..posX+width-1).each do |_posx|
        if @arr[_posy][_posx] == '-'
          products_to_store.push [_posy.to_i, _posx.to_i, type]
        else
          raise 'Product doesn\'t fit'
        end
      end
    end

    products_to_store.each do |p|
      @arr[p[0]][p[1]] = p[2]
    end
  end

  def locate
    
  end

  def remove
  end

  def view
    @arr.each do |a|
      puts a.join ' '
    end
  end
end
