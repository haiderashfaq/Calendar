# frozen_string_literal: true

require_relative 'event_manager'
require_relative 'view'

# controller class
class Calendar
  def initialize
    @events_manager = EventManager.new
    @view           = View.new
  end

  def app
    loop do
      choice = @view.menu_selection
      break if choice.negative?

      home_controller(choice)
    end
  end

  private

  def print_month
    month = @view.month_input
    year = @view.year_input

    no_of_events = Hash.new('')
    (1..@view.days_of_month(month, year)).each do |day|
      events_on_a_day   = @events_manager.events_of_day(Date.new(year, month, day)).size
      no_of_events[day] = "-#{events_on_a_day}" unless events_on_a_day.zero?
    end
    @view.print_month_view(month, year, no_of_events)
  end

  def home_controller(choice)
    case choice
    when 1 then print_month
    when 2 then add_event
    when 3 then remove_event
    when 4 then update_event
    when 5 then events_of_month
    when 6 then events_of_day
    when 7 then read_from_csv
    when 8 then print_all
    end
  end

  def add_event
    event = @events_manager.add_event(@view.get_date, @view.input(:title), @view.input(:desc))
    @view.operation_result(event)
  end

  def remove_event
    print_all
    event_id = @view.event_id_input(@events_manager.all_event_ids)
    result   = @events_manager.remove_event(event_id)
    @view.operation_result(result)
  end

  def update_event
    print_all
    event_id = @view.event_id_input(@events_manager.all_event_ids)
    return if event_id.negative?

    choice = @view.update_selection
    result = case choice
             when 1 then @events_manager.update_date(event_id, @view.get_date)
             when 2 then @events_manager.update_title(event_id, @view.input(:title))
             when 3 then @events_manager.update_desc(event_id, @view.input(:desc))
             end
    @view.operation_result(result)
  end

  def events_of_day
    date   = @view.get_date
    events = @events_manager.events_of_day(date)
    @view.print_events_on_day(events, date)
  end

  def events_of_month
    month  = @view.month_input
    year   = @view.year_input
    events = @events_manager.events_of_month(month, year)
    @view.print_events_of_month(events, month, year)
  end

  def read_from_csv
    @events_manager.read_from_csv(@view.input(:filename))
  rescue StandardError
    @view.operation_result(false, 'Fail to read file')
  else
    @view.operation_result(true)
  end

  def print_all
    @view.print_all_events(@events_manager.instance_eval { @events })
  end
end

Calendar.new.app if __FILE__ == $0
