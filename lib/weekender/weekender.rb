class Weekender

  include WeekenderHelpers

  DAY_NAMES = [ 'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday' ]

  attr_accessor :year,
                :month,
                :day,
                :year_end,
                :month_end,
                :day_end,
                :before,
                :after,
                :events

  def initialize(options={})
    @year       = options[:year]      || Date.today.year
    @month      = options[:month]     || Date.today.month
    @day        = options[:day]       || Date.today.day
    @year_end   = options[:year_end]  || year
    @month_end  = options[:month_end] || month
    @day_end    = options[:day_end]   || day
    @before     = options[:before]    || 0
    @after      = options[:after]     || 0
    @events     = options[:events]    || []
  end

  def weeks
    before + span + after
  end

  def span
    ((spans_to - spans_from).to_i + 1) / 7
  end

  def spans_from
    Date.commercial(date.cwyear, date.cweek, 1)
  end

  def starts_on
    Date.commercial(start_week.cwyear, start_week.cweek, 1)
  end

  def ends_on
    Date.commercial(end_week.cwyear, end_week.cweek, 7)
  end

  def spans_to
    Date.commercial(end_date.cwyear, end_date.cweek, 7)
  end

  def date_on(week, day)
    Date.commercial(week_date(week).cwyear, week_date(week).cweek, day)
  end

  def add_event(date, options={})
    @events << [date, options]
  end

  def event_on?(date)
    if events.empty?
      false
    else
      events_dates.include?(date)
    end
  end

  def events_dates
    events.map { |event| event[0] }
  end

  def events_on(date)
    if event_on?(date)
      events.select { |event| event[0] == date }
    else
      []
    end
  end

  def content_on(date)
    content = ''
    events_on(date).each do |event|
      content << event[1][:content]
    end
    content
  end

  def html_classes_on(date)
    classes = ''
    events_on(date).each do |event|
      classes << ' ' unless classes == ''
      classes << event[1][:html_class]
    end
    classes
  end

  def previous
    Weekender.new(
      :year   => previous_date.year,
      :month  => previous_date.month,
      :day    => previous_date.day,
      :before => before,
      :after  => after
    )
  end

  def next
    Weekender.new(
      :year   => next_date.year,
      :month  => next_date.month,
      :day    => next_date.day,
      :before => before,
      :after  => after
    )
  end

# private

  def date
    Date.new(year, month, day)
  end

  def end_date
    Date.new(year_end, month_end, day_end)
  end

  def start_week
    date - (before * 7)
  end

  def end_week
    end_date + (after * 7)
  end

  def week_date(week)
    start_week + ((week - 1) * 7)
  end

  def previous_date
    starts_on - 1 - (after * 7)
  end

  def next_date
    ends_on + 1 + (before * 7)
  end

end