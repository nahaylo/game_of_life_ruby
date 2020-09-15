class DrawGame
  def call(world)
    clear_screen

    (0..world.max_y-1).each do |y|
      a = ''
      (0..world.max_x-1).each do |x|
        a << DrawCell.call(world.cell_at(x, y))
      end

      puts a
    end
  end

  private

  def clear_screen
    puts "\e[2J\e[f"
  end
end
