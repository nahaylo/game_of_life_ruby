class NextGeneration
  def initialize(world)
    @world = world

    count_neighbours
  end

  def call
    count_neighbours

    all_cells do |cell|
      if cell.live?
        if cell.neighbors < 2 || cell.neighbors > 3
          cell.dead!
        end
      elsif cell.neighbors == 3
        cell.live!
      end
    end
  end

  private

  attr_reader :world

  def count_neighbours
    all_cells do |cell|
      live_count = 0

      CellNeighboursPositions.new(cell).call.each do |x, y|
        live_count += 1 if world.cell_at(x, y)&.live?
      end

      cell.neighbors = live_count
    end
  end

  def all_cells
    world.all_cells.compact.each do |cell|
      yield(cell)
    end
  end
end
