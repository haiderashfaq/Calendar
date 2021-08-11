# frozen_string_literal: true

require_relative 'utilities'
require 'time'

# view.rb
class View
  include UTILITIES

  def print_events_on_day(events)
    print 'Date = ', events[0].date, "\n"
    print_all_events(events)
  end

  def print_events_of_month(events)
    print 'Month = ', events[0].date.strftime("%m\n")
    print_all_events(events)
  end

  def print_month_view(month, year, event_count)
    no_of_days = Date.new(year, month, -1).day
    weekday = Date.new(year, month, 1)

    puts weekday.strftime("-----%B, %Y-----\n")
    weekday = weekday.wday

    puts %w{Sun Mon Tue Wed Thu Fri Sat}.join("\t")

    [
      * Array.new(weekday),
      * (1..no_of_days)
    ].each_slice(7).map { |week| puts week.map { |date| '%2s' % date + '%-3s' %event_count[date] }.join("\t") }
    puts ''
  end

  def user_selection(max_choices, menu_selection)
    choice = nil
    loop do
      print_menu if menu_selection == 'menu'
      print_updates if menu_selection == 'update'
      choice = begin
        Integer(gets)
      rescue StandardError
        -1
      end
      puts ''
      break unless choice.negative? || choice > max_choices
    end
    choice
  end

  # get date as input
  def get_date
    date = nil
    loop do
      print 'Enter Date of Event (yyyy/mm/dd) '
      date = gets
      date = str_to_date(date)
      puts ''
      break if date

      puts 'Error: Invalid Input!! Try Again.....'
    end
    date
  end

  def month_input
    month = nil
    loop do
      print 'Enter month(1-12): '
      month = begin
        Integer(gets)
      rescue StandardError
        month = 0
      end
      puts ''
      break unless month < 1 || month > 12

      puts 'Error: Invalid Input!! Try Again...'
    end
    month
  end

  def year_input
    year = nil
    loop do
      print 'Enter year: '
      year = begin
        Integer(gets)
      rescue StandardError
        year = -1
      end
      puts ''
      break unless year == -1
    end
    year
  end

  def event_id_input(total_events)
    id = nil
    loop do
      print 'Enter Event ID (0 to go back): '
      id = begin
        Integer(gets)
      rescue StandardError
        id = -1
      end
      puts ''
      break unless id.negative? || id > total_events

      puts 'Error: Invalid Input!! Try Again...'
    end
    id
  end

  def operation_result(result, *splat)
    if result
      puts 'Operation Successfull!!!'
    else
      puts 'Operation Failed.....'
    end
    puts splat
    puts ''
  end

  def print_all_events(events)
    puts '%2s  ' %'ID' + '%-10s ' %'Date' + '%-10s ' %'Title' + 'Description'
    events.each do |event|
      puts '%2s  ' % event.id + '%-10s ' % event.date + '%-10s ' % event.title + event.description
    end
    puts ''
  end

  def input(token) 
    print 'Enter event title: ' if token == 'title'
    print 'Enter description: ' if token == 'desc'
    print 'Enter csv filename: ' if token == 'file'
    gets.chomp
  end

  private

  def print_menu
    puts '============Menu==============='
    puts '1. Print Month (Calendar Style)'
    puts '2. Add Event'
    puts '3. Remove Event'
    puts '4. Update Event'
    puts '5. Print All Events of a Month'
    puts '6. Print All Events of a Day'
    puts '7. Read from CSV file'
    puts '8. Print all events on Calendar '
    puts '0. EXIT'
    print 'Choose an operation(0-8): '
  end

  def print_updates
    puts '1. Change Date'
    puts '2. Chnage Title'
    puts '3. Chnage Description'
    print 'What u want to Change?(1-3): '
  end
end
