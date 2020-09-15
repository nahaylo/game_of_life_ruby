module SeedWorld
  module_function

  def call(world, cells = [])
    cells.each do |x, y|
      world.seed(x, y)
    end
  end
end
