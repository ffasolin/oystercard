require "./lib/oystercard"



describe Oystercard do
  let(:station) {double}

  it 'has a balance' do
    expect(subject).to respond_to :balance
  end

  it 'has a blank history' do
    expect(subject.history).to eq([])
  end

  it 'begins at a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'adds 10 to the balance' do
    expect(subject.top_up(10)).to eq(10)
  end

  it 'adds 10 to the balance of 10' do
    subject.top_up(10)
    expect(subject.top_up(10)).to eq(20)
  end

  it 'should raise an error if 100 is added' do
    expect{ subject.top_up(100) }.to raise_error("card limit exceeded: Maximum Balance is £#{Oystercard::MAXIMUM_BALANCE}")
  end

  it 'checks the journey status' do
    expect(subject).to respond_to :in_journey?
  end

  it 'changes the journey status to true' do
    subject.top_up(5)
    expect{subject.touch_in(station)}.to change{subject.in_journey?}.from(false).to(true)
  end

  it 'changes the journey status to false' do
    subject.top_up(5)
    subject.touch_in(station)
    expect{ subject.touch_out(station) }.to change{ subject.in_journey? }.from(true).to(false)
  end


  it 'should raise an error if we deduct when balance is less than £1' do
    expect{ subject.touch_in(station) }.to raise_error("Min balance is £#{Oystercard::MINIMUM_FARE}")
  end

  it 'should deduct £1 on touching out' do
    subject.top_up(5)
    subject.touch_in(station)
    expect{ subject.touch_out(station) }.to change{ subject.balance }.from(5).to(4)
  end

  it 'should remember the station it touched in at' do
    subject.top_up(5)
    subject.touch_in('Aldgate')
    expect(subject.journey.entry_station).to eq "Aldgate"
  end

  it "should set journey to nil at touch out" do
    subject.top_up(7)
    subject.touch_in(station)
    expect{ subject.touch_out(station) }.to change{ subject.journey }.to be_nil
  end

  it "should record one journey from Fulham to Aldgate" do
    subject.top_up(7)
    subject.touch_in("Fulham")
    subject.touch_out("Aldgate")
    expect(subject.history).to eq ["Fulham" => "Aldgate"]
  end

end
