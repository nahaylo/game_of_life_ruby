class Cell
  attr_reader :x, :y
  attr_accessor :neighbors

  def self.live
    new(live: true)
  end

  def initialize(live: false, x: nil, y: nil)
    @live = live
    @x = x
    @y = y
  end

  def to_s
    "#{x}=#{y} live: #{@live} neighbors: #{neighbors}"
  end
  alias_method :inspect, :to_s

  def set_position(x, y)
    @x = x
    @y = y
  end

  def live?
    @live
  end

  def dead?
    !live?
  end

  def live!
    @live = true
  end

  def dead!
    @live = false
  end
end
