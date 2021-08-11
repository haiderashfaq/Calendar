# frozen_string_literal: true

require 'time'

# class defining what an event look like
class Event
  @@next_event_id = 1
  attr_accessor :date, :description, :title, :id

  def initialize(date, title = '', desc = '')
    @description = desc
    @title = title
    @date = date
    @id = @@next_event_id
    @@next_event_id += 1
  end

  def update_event(date = @date, title = @title, desc = @description)
    @description = desc
    @title = title
    @date = date
  end
end
