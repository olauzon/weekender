Given /^I want a calendar built around (.*), (.*)$/ do |day_name, date|
  @date = make_date(date)
  @date.day_name.should eql(day_name)
end

When /^I set the number of weeks to come before to (.*)$/ do |before|
  @before = before.to_i
end

When /^I set the number of weeks to come after to (.*)$/ do |after|
  @after = after.to_i
end

Then /^it should have (.*) weeks$/ do |weeks|
  @weekender = Weekender.new( :year   => @date.year,
                              :month  => @date.month,
                              :day    => @date.day,
                              :before => @before,
                              :after  => @after)
  @weekender.weeks.should eql(weeks.to_i)
end

Then /^it should start on Monday (.*)$/ do |date|
  start_date = make_date(date)
  start_date.day_name.should eql('Monday')
  @weekender.starts_on.month.should eql(start_date.month)
  @weekender.starts_on.year.should eql(start_date.year)
  @weekender.starts_on.day.should eql(start_date.day)
  @weekender.starts_on.should eql(start_date)
end

Then /^it should end on Sunday (.*)$/ do |date|
  end_date = make_date(date)
  end_date.day_name.should eql('Sunday')
  @weekender.ends_on.should eql(end_date)
end

def make_date(date)
  d = date.split('-')
  Date.new(d[0].to_i, d[1].to_i, d[2].to_i)
end
