require_relative '../app/autoload'
require 'rspec/collection_matchers'

describe World do
  let(:max_x) { 15 }
  let(:max_y) { 16 }

  let(:object) { described_class.new(max_x: max_x, max_y: max_y) }

  subject { object }

  it 'renders world with cells' do
    expect(subject.cells).to have(max_x).items

    expect(subject.cells.first).to have(max_y).items
    expect(subject.cells.last).to have(max_y).items

    expect(subject.cells[1][1]).to be_a_kind_of Cell

    expect(subject.all_cells.count).to be max_x*max_y
  end

  it 'nullifies border' do
    expect(subject.cells.first.first).to be_nil
    expect(subject.cells.first.last).to be_nil

    expect(subject.cells.first[1]).to be_nil

    expect(subject.cells.last.first).to be_nil
    expect(subject.cells.last.last).to be_nil
  end

  describe '#seed' do
    let(:x) { 10 }
    let(:y) { 12 }
    let(:error_message) { 'Seeding around the frame is prohibited' }

    it 'does not allowed to seed around the frame' do
      expect { object.seed(0, 0) }.to raise_error(StandardError, error_message)
      expect { object.seed(max_x-1, max_y) }.to raise_error(StandardError, error_message)
      expect { object.seed(max_x-1, 5) }.to raise_error(StandardError, error_message)
      expect { object.seed(5, max_y-1) }.to raise_error(StandardError, error_message)
    end

    it 'seeds live cell' do
      object.seed(x, y)

      expect(object.cell_at(5, 5)).to be_dead
      expect(object.cell_at(max_x-2, max_y-2)).to be_dead
      expect(object.cell_at(x, y)).to be_live
    end
  end
end
