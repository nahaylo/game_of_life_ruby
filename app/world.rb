class World
  attr_reader :cells, :max_x, :max_y

  def initialize(max_x:, max_y:)
    @max_x = max_x
    @max_y = max_y
    @cells = Array.new(max_x) { Array.new(max_y) }

    seed_cells
  end

  def seed(x, y, cell: Cell.live)
    raise 'Seeding around the frame is prohibited' if frame_position?(x, y)

    @cells[x][y] = cell.tap { |c| c.set_position(x, y) }
  end

  def cell_at(x, y)
    @cells[x][y]
  end

  def all_cells
    @cells.flatten
  end

  private

  def seed_cells
    (1..max_x-2).each do |x|
      (1..max_y-2).each do |y|
        @cells[x][y] = Cell.new(x: x, y: y)
      end
    end
  end

  def frame_position?(x, y)
    x == 0 || x == max_x-1 || y == 0 || y == max_y-1
  end
end
