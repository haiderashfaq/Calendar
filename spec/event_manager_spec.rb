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

  # update date
  it 'Testing update_date return new date' do
    event_manager = EventManager.new
    event = event_manager.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
    new_date = Date.new(2021, 8, 12)
    event_manager.update_date(event.id, new_date)
    expect(event.date).to eq new_date
  end
  it 'Testing update_date with foul event_id' do
    expect(EventManager.new.update_date(1, 'test')).to eq nil
  end

  # update title
  it 'Testing update_title returns new title' do
    event_manager = EventManager.new
    event = event_manager.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
    event_manager.update_title(event.id, 'Birthday')
    expect(event.title).to eq 'Birthday'
  end
  it 'Testing update_title with foul event_id' do
    expect(EventManager.new.update_title(1, 'test')).to eq nil
  end

  # update description
  it 'Testing update_desc returns new description' do
    event_manager = EventManager.new
    event = event_manager.add_event(Date.new(1999, 12, 12), 'Birthday Celeb', 'Birthday celebrated')
    event_manager.update_desc(event.id, 'celebrate hard and long')
    expect(event.description).to eq 'celebrate hard and long'
  end
  it 'Testing update_desc with foul event_id' do
    expect(EventManager.new.update_desc(1, 'test')).to eq nil
  end

  # cases for events of a day and month

  # events_of_day
  it 'Testing events_of_day with some events on that day' do
    event_manager = EventManager.new
    date = Date.new(1999, 12, 12)
    event_manager.add_event(date, 'Birthday Celeb', 'Birthday celebrated')
    event_manager.add_event(date, 'Birthday Celeb', 'Birthday celebrated')
    expect(event_manager.events_of_day(date).size).to eq 2
  end
  it 'Testing events_of_day with no events on that day' do
    event_manager = EventManager.new
    date = Date.new(1999, 12, 12)
    expect(event_manager.events_of_day(date).size).to eq 0
  end

  # events_of_month
  it 'Testing events_of_month with some events on that month' do
    event_manager = EventManager.new
    date = Date.new(1999, 12, 1)
    event_manager.add_event(date, 'Birthday Celeb', 'Birthday celebrated')
    event_manager.add_event(date + 1, 'Birthday Celeb', 'Birthday celebrated')
    expect(event_manager.events_of_month(date.month, date.year).size).to eq 2
  end
  it 'Testing events_of_month with no events on that month' do
    event_manager = EventManager.new
    expect(event_manager.events_of_month(12, 2021).size).to eq 0
  end

  # total events on calendar
  it 'total events on calendar' do
    event_manager = EventManager.new
    date = Date.new(1999, 12, 1)
    event_manager.add_event(date, 'Birthday Celeb', 'Birthday celebrated')
    event_manager.add_event(date + 1, 'Birthday Celeb', 'Birthday celebrated')
    expect(event_manager.total_events).to eq 2
  end

  # case for find event
  it 'Testing for find_event functionality' do
    event_manager = EventManager.new
    date = Date.new(1999, 12, 1)
    event = event_manager.add_event(date, 'Birthday Celeb', 'Birthday celebrated')
    event_manager.add_event(date + 1, 'Birthday Celeb', 'Birthday celebrated')
    expect(event_manager.find_event(event.id).id).to eq event.id
  end
end
