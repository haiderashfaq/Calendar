# frozen_string_literal: true

require 'time'
# moduel containing utilitiy functions
module UTILITIES
  # validate date entered
  def str_to_date(date)
    date.chomp!
    catch(:invalid) do
      date = date.split('/')
      date.collect!(&:to_i)  # change input from str to int
      throw :invalid unless Date.valid_date?(date[0], date[1], date[2])
      Date.new(date[0], date[1], date[2])
    end
  end
end
