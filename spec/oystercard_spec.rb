require 'oystercard'

describe Oystercard do

  it 'has a balance of zero' do
     expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
  	it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'raise error when over balance limit' do
      expect{ subject.top_up(91) }.to raise_error "ERROR: balance over maximum limit of #{described_class::MAX_BALANCE}"
    end
  end

  describe '#deduct' do

    it 'should deduct from balance' do
      subject.top_up(6)
      expect(subject.deduct(3)).to eq 3
    end
  end
end
