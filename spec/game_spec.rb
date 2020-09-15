require_relative '../app/autoload'
require 'rspec/collection_matchers'

describe Game do
  it 'init the game' do
    expect(described_class.new).to be_a_kind_of Game
  end
end
