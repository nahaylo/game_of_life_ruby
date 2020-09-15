class Game
  attr_reader :world, :draw_game

  def initialize(
    world: World.new(max_x: 40, max_y: 25),
    draw_game: DrawGame.new,
    initial_pattern: pattern_sample
  )
    @world = world
    @draw_game = draw_game
    @initial_pattern = initial_pattern

    @next_generate = NextGeneration.new(world)

    seed_world

    draw
  end

  def next_turn
    next_generate.call

    draw
  end

  private

  attr_reader :next_generate, :initial_pattern

  def draw
    draw_game.call(world)
  end

  def seed_world
    SeedWorld.call(world, initial_pattern)
  end

  def pattern_sample
    [
      [10, 10],
      [11, 10],
      [12, 10]
    ]
  end
end
