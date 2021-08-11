# frozen_string_literal: true

require_relative 'event'
load 'utilities.rb'
require 'csv'
# class Managing Eevets and related funcitonalities
class EventManager
  include UTILITIES

  def initialize
    @events = []
  end

  def add_event(date, title = '', desc = '')
    @events[@events.size] = Event.new(date, title, desc)
  end

  def remove_event(event_id)
    @events&.reject! { |event| event.id == event_id }
  end

  def update_date(event_id, date)
    event = find_event(event_id)
    event&.date = date
  end

  def update_title(event_id, title)
    event = find_event(event_id)
    event&.title = title
  end

  def update_desc(event_id, desc)
    event = find_event(event_id)
    event&.description = desc
  end

  def events_of_day(date)
    @events&.find_all { |event| event.date == date }
  end

  def events_of_month(month, year)
    @events&.find_all { |event| event.date.month == month and event.date.year == year }
  end

  def total_events
    @events&.size
  end

  def read_from_csv(filename)
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, headers: false)
    csv.each do |row|
      date = str_to_date(row[0])
      next unless date

      add_event(date, row[1], row[2])
    end
  end

  private

  def find_event(event_id)
    @events&.find { |evnt| evnt.id == event_id }
  end
end
