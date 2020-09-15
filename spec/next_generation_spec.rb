require_relative '../app/autoload'
require 'rspec/collection_matchers'

describe NextGeneration do
  let(:max_x) { 15 }
  let(:max_y) { 16 }
  let(:world) { World.new(max_x: max_x, max_y: max_y) }

  let!(:seed_world) { SeedWorld.call(world, initial_pattern) }
  let!(:object) { described_class.new(world) }

  describe '#call' do
    let(:initial_pattern) do
      # 9  |
      # 10 |  1  2  1
      # 11 | d2 d3
      #     ____________
      #      10 11 12 13
      [
        [10, 10],
        [11, 10],
        [12, 10]
      ]
    end
    let(:cell_10x10) { world.cell_at(10, 10) }
    let(:cell_10x11) { world.cell_at(10, 11) }
    let(:cell_11x10) { world.cell_at(11, 10) }
    let(:cell_11x11) { world.cell_at(11, 11) }

    context 'live cell with fewer than two live neighbours dies' do
      specify do
        expect(cell_10x10).to be_live
        expect(cell_10x10.neighbors).to eq 1

        expect { object.call }.to change { cell_10x10.live? }.from(true).to(false)
      end
    end

    context 'live cell with two or three live neighbours lives on to the next generation' do
      specify do
        expect(cell_11x10).to be_live
        expect(cell_11x10.neighbors).to eq 2

        expect { object.call }.not_to change { cell_11x10.live? }
      end
    end

    context 'live cell with more than three live neighbours dies, as if by overpopulation' do
      let(:initial_pattern) do
        # 9   | x        0
        # 10  | 4  x
        # 11  | x  x
        #     ____________
        #      10 11 12 13
        [
          [10, 9],
          [10, 10],
          [10, 11],
          [11, 10],
          [11, 11],
          [13, 9]
        ]
      end
      let(:cell_13x9) { world.cell_at(13, 9) }

      specify do
        expect(cell_10x10).to be_live
        expect(cell_10x10.neighbors).to eq 4

        expect { object.call }.to change { cell_10x10.live? }.from(true).to(false)
      end

      it 'all other live cells die' do
        expect(cell_13x9).to be_live
        expect(cell_13x9.neighbors).to eq 0

        expect { object.call }.to change { cell_13x9.live? }.from(true).to(false)
      end
    end

    context 'dead cell with exactly three live neighbours becomes a live cell, as if by reproduction' do
      specify do
        expect(cell_11x11).to be_dead
        expect(cell_11x11.neighbors).to eq 3

        expect { object.call }.to change { cell_11x11.live? }.from(false).to(true)
      end
    end

    context 'all other dead cells stay dead' do
      let(:cell_1x1) { world.cell_at(1, 1) }

      it 'dead cell with two live neighbours' do
        expect(cell_10x11).to be_dead
        expect(cell_10x11.neighbors).to eq 2

        expect { object.call }.not_to change { cell_10x11.dead? }
      end

      it 'dead cell w/o live neighbours' do
        expect(cell_1x1).to be_dead
        expect(cell_1x1.neighbors).to eq 0

        expect { object.call }.not_to change { cell_1x1.dead? }
      end
    end
  end
end
