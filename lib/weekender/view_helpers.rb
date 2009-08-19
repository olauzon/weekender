module WeekenderHelpers

  attr_reader :date_format,
              :name_format

  def display(options={})
    @date_format  = options[:date_format] || '%Y-%m-%d'
    @name_format  = options[:name_format] || :long
    output = '<table class="weekender">'
    output.add header_row
    output.add week_rows(:reverse => (options[:reverse] || false))
    output.add '</table>'
  end

private

  def header_row
    output = '<tr class="weekender_header">'.tab(2)
    Weekender::DAY_NAMES.each do |day_name|
      output.add ['<th>', abbreviate(day_name), '</th>'].join.tab(4)
    end
    output.add '</tr>'.tab(2)
  end

  def week_rows(options={})
    output = ''
    if options[:reverse] && options[:reverse] == true
      weeks.downto(1) do |week|
        if week == weeks
          output = '<tr>'.tab(2)
        else
          output.add '<tr>'.tab(2)
        end
        1.upto(7) do |day|
          output.add day_cell(week, day)
        end
        output.add '</tr>'.tab(2)
      end
    else
      1.upto(weeks) do |week|
        if week == 1
          output = '<tr>'.tab(2)
        else
          output.add '<tr>'.tab(2)
        end
        1.upto(7) do |day|
          output.add day_cell(week, day)
        end
        output.add '</tr>'.tab(2)
      end
    end
    output
  end

  def day_cell(week, day)
    date = date_on(week, day)
    output = '<td>'
    output << '<a href="#" class="weekender_date">'
    output << date.strftime(date_format)
    output << '</a>'
    output << content_on(date.to_s)
    output << '</td>'
    output.tab(4)
  end

  def abbreviate(day_name)
    if name_format == :medium
      day_name[0..2]
    elsif name_format == :short
      day_name[0..0]
    else
      day_name
    end
  end

end
