require 'forwardable'

class CellNeighboursPositions
  extend Forwardable

  def_delegators :cell, :x, :y

  def initialize(cell)
    @cell = cell
  end

  def call
    [
      [x-1, y-1],
      [x-1, y],
      [x-1, y+1],
      [x, y-1],
      [x, y+1],
      [x+1, y-1],
      [x+1, y],
      [x+1, y+1]
    ]
  end

  private

  attr_reader :cell
end
