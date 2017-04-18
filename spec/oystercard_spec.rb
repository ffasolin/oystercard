require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:balance) }

  describe '#top_up' do
    it 'should allow user to #top_up' do
      expect(subject.top_up(0)).to eq 0
    end

    it 'should allow user to #top_up' do
      expect(subject.top_up(91093)).to eq 91093
    end
  end
end

#/Users/Fasolin/Projects/oystercard/spec/oystercard_spec.rb:1
#uninitialized constant
