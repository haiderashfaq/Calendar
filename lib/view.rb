# frozen_string_literal: true

require_relative 'utilities'
require 'time'

# view.rb
class View
  include UTILITIES

  USER_PROMPTS = {
    title: 'Enter event title: ',
    desc: 'Enter description: ',
    filename: 'Enter csv filename: '
  }.freeze

  def days_of_month(month, year)
    Date.new(year, month, -1).day
  end

  def print_events_on_day(events, date)
    print 'Date = ', date, "\n"
    print_all_events(events)
  end

  def print_events_of_month(events, month, year)
    print 'Month = ', month, year, "\n"
    print_all_events(events)
  end

  def print_month_view(month, year, event_count)
    no_of_days         = days_of_month(month, year)
    first_day_of_month = Date.new(year, month, 1)

    puts first_day_of_month.strftime("-----%B, %Y-----\n")
    first_weekday = first_day_of_month.wday

    puts %w{Sun Mon Tue Wed Thu Fri Sat}.join("\t")

    [
      * Array.new(first_weekday),
      * (1..no_of_days)
    ].each_slice(7).map { |week| puts week.map { |date| '%2s' % date + '%-3s' %event_count[date] }.join("\t") }
    puts ''
  end

  def menu_selection
    choice = nil
    loop do
      print_menu
      choice = gets.to_i
      puts ''
      break if choice.negative? || choice <= 8
    end
    choice
  end

  def update_selection
    choice = nil
    loop do
      print_updates
      choice = gets.to_i
      puts ''
      break if choice.negative? || choice <= 3
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
      break if date

      puts 'Error: Invalid Input!! Try Again.....'
    end
    date
  end

  def month_input
    month = nil
    loop do
      print 'Enter month(1-12): '
      month = gets.to_i
      break unless month < 1 || month > 12

      puts 'Error: Invalid Input!! Try Again...'
    end
    month
  end

  def year_input
    year = nil
    loop do
      print 'Enter year: '
      year = gets.to_i
      break unless year.negative?
    end
    year
  end

  def event_id_input(all_event_ids)
    id = nil
    loop do
      print 'Enter Event ID (-1 to go back): '
      id = gets.to_i
      puts ''
      break if id == -1 || all_event_ids.index(id)

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
      puts '%2s  ' % event.id + '%-10s ' % event.date + '%-10s ' % event.title[0...10] + event.description
    end
    puts ''
  end

  def input(token)
    print USER_PROMPTS[token]
    gets.chomp
  end

  private

  def print_menu
    puts '===============Menu=================='
    puts ' 1. Print Month (Calendar Style)'
    puts ' 2. Add Event'
    puts ' 3. Remove Event'
    puts ' 4. Update Event'
    puts ' 5. Print All Events of a Month'
    puts ' 6. Print All Events of a Day'
    puts ' 7. Read from CSV file'
    puts ' 8. Print all events on Calendar '
    puts '-1. EXIT'
    print 'Choose an operation(1-8/-1): '
  end

  def print_updates
    puts '1. Change Date'
    puts '2. Chnage Title'
    puts '3. Chnage Description'
    print 'What u want to Change?(1-3): '
  end
end
