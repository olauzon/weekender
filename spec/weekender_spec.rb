require File.dirname(__FILE__) + '/spec_helper'

describe Weekender do

  describe "defaults" do

    before(:each) do
      @weekender = Weekender.new
    end

    it "should be this year" do
      @weekender.year.should eql(Date.today.year)
    end

    it "should be this month" do
      @weekender.month.should eql(Date.today.month)
    end

    it "should be today" do
      @weekender.day.should eql(Date.today.day)
    end

    it "should have 0 weeks before" do
      @weekender.before.should eql(0)
    end

    it "should have 0 weeks after" do
      @weekender.after.should eql(0)
    end

    it "should have 1 week" do
      @weekender.weeks.should eql(1)
    end

    it "should start on a Monday" do
      @weekender.starts_on.day_name.should eql("Monday")
    end

    it "should end on a Sunday" do
      @weekender.ends_on.day_name.should eql("Sunday")
    end

    it "should have a date by week number and day number" do
      @weekender.date_on(1, 1).should eql(@weekender.starts_on)
    end

    it "should have a date on end week and end day" do
      @weekender.date_on(1, 7).should eql(@weekender.ends_on)
    end

    it "should start and end on the same date" do
      @weekender.date.strftime('%Y-%m-%d').
        should eql(@weekender.end_date.strftime('%Y-%m-%d'))
    end

    it "should start and end on the same week" do
      @weekender.start_week.should eql(@weekender.end_week)
    end

  end

  describe "with start date" do

    before(:each) do
      @weekender = Weekender.new( :year   => 1999,
                                  :month  => 12,
                                  :day    => 31,
                                  :before => 3,
                                  :after  => 4)
    end

    it "should be in 1999" do
      @weekender.year.should eql(1999)
    end

    it "should start on a Monday" do
      @weekender.starts_on.day_name.should eql("Monday")
    end

    it "should start in December" do
      @weekender.starts_on.month_name.should eql('December')
    end

    it "should start on the 6th" do
      @weekender.starts_on.day_of_month.should eql(6)
    end

    it "should start in 1999" do
      @weekender.starts_on.year.should eql(1999)
    end

    it "should start on Monday, December 6th, 1999" do
      @weekender.starts_on.should eql(Date.new(1999, 12, 6))
    end

    it "should end on a Sunday" do
      @weekender.ends_on.day_name.should eql("Sunday")
    end

    it "should end in January" do
      @weekender.ends_on.month_name.should eql("January")
    end

    it "should end on the 29th" do
      @weekender.ends_on.day_of_month.should eql(30)
    end

    it "should end in 2000" do
      @weekender.ends_on.year.should eql(2000)
    end

  end

  describe "with start and end date" do

    before(:each) do
      @weekender = Weekender.new( :year       => 2009,
                                  :month      => 5,
                                  :day        => 1,
                                  :year_end   => 2009,
                                  :month_end  => 5,
                                  :day_end    => 15,
                                  :before     => 0,
                                  :after      => 0)
    end

    it "should start on Monday, April 27th, 2009" do
      @weekender.starts_on.should eql(Date.new(2009, 4, 27))
    end

    it "should end on a Sunday, May 17th, 2009" do
      @weekender.ends_on.should eql(Date.new(2009, 5, 17))
    end

    it "should have 3 weeks" do
      @weekender.weeks.should eql(3)
    end

  end

  describe 'events' do

    it 'should be an array of events' do
      Weekender.new.events.should be_a_kind_of(Array)
    end

    it 'should be initialized as empty by default' do
      Weekender.new.events.should be_empty
    end

    describe 'adding' do

      before(:each) do
        @weekender = Weekender.new
      end

      it "should not be an eventful day by default" do
        @weekender.event_on?(Date.today).should be_false
      end

      it 'should add events to the specified day' do
        @weekender.add_event(Date.today - 1)
        @weekender.event_on?(Date.today - 1).should be_true
      end

    end

    describe 'adding with content' do

      before(:each) do
        @weekender = Weekender.new

        @weekender.add_event(Date.today - 1,
                             :html_class => 'first',
                             :content    => '<p>special content 1</p>')

        @weekender.add_event(Date.today - 1,
                             :html_class => 'second',
                             :content    => '<p>special content 2</p>')

        @weekender.add_event(Date.today - 2,
                             :html_class => 'third',
                             :content    => 'special content 3')
      end

      it "should have two events yesterday" do
        @weekender.events_on(Date.today - 1).length.should eql(2)
      end

      it "should store the content" do
        @weekender.content_on(Date.today - 1).
          should eql('<p>special content 1</p><p>special content 2</p>')
      end

      it "should store the HTML class" do
        @weekender.html_classes_on(Date.today - 1).
          should eql('first second')
      end

    end

  end

  describe "day names" do

    it "should be Monday through Sunday" do
      Weekender::DAY_NAMES.should eql(
        [ 'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday' ]
      )
    end

  end

  describe "previous and next" do

    describe "defaults" do

      it "should have previous" do
        Weekender.new.previous.should be
      end

      it "should have next" do
        Weekender.new.next.should be
      end

    end

    describe "with weekender" do

      before(:each) do
        @weekender = Weekender.new(:year    => 2009,
                                   :month   => 5,
                                   :day     => 1,
                                   :before  => 1,
                                   :after   => 1)
      end

      it "should return the previous weekender" do
        @weekender.previous.month.should eql(4)
      end

      it "should return the next weekender" do
        @weekender.next.month.should eql(5)
      end

    end

  end

  describe 'generate HTML' do

    describe 'for default' do

      before(:each) do
        @weekender = Weekender.new(:year    => 2009,
                                   :month   => 5,
                                   :day     => 1,
                                   :before  => 1,
                                   :after   => 1)
        @weekender.add_event("2009-05-01",
                            :content => "<p>This is an event</p>")
        @weekender.add_event("2009-05-02",
                            :content => "<p>This is another event</p>")
        @default_table = File.read('spec/fixtures/weekender.html').chomp
      end

      it 'should display an HTML calendar' do
        @weekender.display.should == @default_table
      end

    end

  end

end
