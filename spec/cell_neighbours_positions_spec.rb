require_relative '../app/autoload'
require 'rspec/collection_matchers'

describe CellNeighboursPositions do
  let(:cell) { Cell.new(x: 10, y: 10) }

  let(:object) { described_class.new(cell) }

  describe '#call' do
    subject { object.call }

    it { is_expected.to match_array [[9, 9], [9, 10], [9, 11], [10, 9], [10, 11], [11, 9], [11, 10], [11, 11]] }
  end
end
