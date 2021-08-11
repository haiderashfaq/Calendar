# frozen_string_literal: true

require './lib/event_manager'

describe 'event_manager' do
  # Cases of add_event
  it 'Testing add_event with Date only' do
    expect(EventManager.new.add_event(Date.new(1999, 12, 12)).date).to eq Date.new(1999, 12, 12)
  end
  it 'Testing add_event with Date, title' do
    expect(EventManager.new.add_event(Date.new(1999, 12, 12), 'Birthday Celeb').title).to eq 'Birthday Celeb'
  end
  it 'Testing add_event with Date, Title and description' do
    event = EventManager.new.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
    expect(event.description).to eq 'Birthday celebrated'
  end

  # cases of remove event
  it 'size of Array reduced if event is removed successsfully' do
    event_manager = EventManager.new
    event = event_manager.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
    size = event_manager.total_events
    event_manager.remove_event(event.id)
    expect(event_manager.total_events).to eq size - 1
  end
  it 'returns nil if event does not exist' do
    expect(EventManager.new.remove_event(1)).to eq nil
  end
  it 'returns nil if try remove after removing the same event' do
    event_manager = EventManager.new
    event = event_manager.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
    event_manager.remove_event(event.id)
    expect(event_manager.remove_event(event.id)).to eq nil
  end

  # cases for update event

  #update date
  # it 'return new date if event exists' do
  #   event_manager = EventManager.new
  #   event = event_manager.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
  #   size = event_manager.total_events
  #   event_manager.remove_event(event.id)
  #   expect(event_manager.total_events).to eq size - 1
  # end
end
