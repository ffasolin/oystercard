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

  describe '#touch_in' do
    it 'gives status touched in' do
      subject.touch_in
      expect(subject.status).to eq "Touched in."
    end
  end

  describe '#touch_out' do
    it 'gives status touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.status).to eq "Touched out."
    end
  end

  describe '#in_journey?' do
    it 'returns true when touched in' do
      subject.touch_in
      should be_in_journey
    end

    it 'returns false when touched out' do
      expect(subject.in_journey?).to eq false
    end
  end

end
