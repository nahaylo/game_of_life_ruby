require_relative '../app/autoload'
require 'rspec/collection_matchers'

describe SeedWorld do
  let(:max_x) { 25 }
  let(:max_y) { 26 }
  let(:world) { World.new(max_x: max_x, max_y: max_y) }

  let(:initial_pattern) do
    # 15 |     x
    # 14 |
    # 13 |     x
    # 12 | x      x
    #     ____________
    #      10 11 12 13
    [
      [10, 12],
      [11, 15],
      [11, 13],
      [12, 12]
    ]
  end

  let!(:object) { described_class.call(world, initial_pattern) }

  describe '#call' do
    it 'seeds cells' do
      expect(world.cell_at(1, 1)).to be_dead
      expect(world.cell_at(max_x-2, max_y-2)).to be_dead

      expect(world.cell_at(10, 12)).to be_live
      expect(world.cell_at(11, 15)).to be_live
      expect(world.cell_at(11, 13)).to be_live
      expect(world.cell_at(12, 12)).to be_live
    end
  end
end
