Feature: Making a calendar
  In order to keep track of days
  As a person
  I want a calendar

  Scenario Outline: Weekly calendar
    Given I want a calendar built around <day_name>, <date>
    When I set the number of weeks to come before to <before>
    And I set the number of weeks to come after to <after>
    Then it should have <weeks> weeks
    And it should start on Monday <start_date>
    And it should end on Sunday <end_date>

  Examples:
    | day_name  | date        | before  | after | weeks | start_date  | end_date    |
    | Monday    | 2008-06-09  | 1       | 1     | 3     | 2008-06-02  | 2008-06-22  |
    | Tuesday   | 2006-12-19  | 0       | 2     | 3     | 2006-12-18  | 2007-01-07  |
    | Wednesday | 1987-01-07  | 1       | 0     | 2     | 1986-12-29  | 1987-01-11  |
    | Thursday  | 1964-01-02  | 0       | 0     | 1     | 1963-12-30  | 1964-01-05  |
    | Friday    | 1999-12-31  | 3       | 4     | 8     | 1999-12-06  | 2000-01-30  |
    | Saturday  | 1979-12-29  | 10      | 10    | 21    | 1979-10-15  | 1980-03-09  |
    | Sunday    | 2009-02-15  | 2       | 2     | 5     | 2009-01-26  | 2009-03-01  |
