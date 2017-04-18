require 'oystercard'

describe Oystercard do
let(:station){double :station}

  it 'has empty journey history' do
    expect(subject.journey_history).to be_empty
  end

  it 'records journey' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.journey_history).to_not be_empty
    p subject.journey_history
  end

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
      subject.touch_out(station)
      expect(subject.balance).to eq 5
    end
  end

  describe '#touch_in' do
    #let (:station){double(:station)}

    it 'gives status touched in' do
      subject.top_up(described_class::MIN_BALANCE)
      subject.touch_in(station)
      expect(subject.status).to eq "Touched in."
    end
    it 'gives error when balance is insufficient' do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance."
    end
    it 'records point of entry' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'forgets point of entry' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'gives status touched out' do
      subject.top_up(described_class::MIN_BALANCE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.status).to eq "Touched out."
    end

    it 'deducts balance after #touch_out' do
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-1)
    end
  end

  describe '#in_journey?' do
    it 'returns true when touched in' do
      subject.top_up(described_class::MIN_BALANCE)
      subject.touch_in(station)
      should be_in_journey
    end

    it 'returns false when touched out' do
      expect(subject.in_journey?).to eq false
    end
  end

end
