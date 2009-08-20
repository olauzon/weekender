require 'rubygems'
require 'sinatra'
require 'haml'
require 'lib/weekender'

get '/' do
  @weekender = Weekender.new(params[:options] || '')
  haml "
%h1.title weekender
%p This example shows a limited set of options.
%div.options
  %form(method=\"get\" action=\"/\")
    %p
      %label(for=\"options_year\") year
      %br
      %input(type=\"text\" name=\"options[year]\" id=\"options_year\" value=\"#{@weekender.year}\")
    %p
      %label(for=\"options_month\") month
      %br
      %input(type=\"text\" name=\"options[month]\" id=\"options_month\" value=\"#{@weekender.month}\")
    %p
      %label(for=\"options_day\") day
      %br
      %input(type=\"text\" name=\"options[day]\" id=\"options_day\" value=\"#{@weekender.day}\")
    %p
      %label(for=\"options_before\") number of weeks before
      %br
      %input(type=\"text\" name=\"options[before]\" id=\"options_before\" value=\"#{@weekender.before}\")
    %p
      %label(for=\"options_after\") number of weeks after
      %br
      %input(type=\"text\" name=\"options[after]\" id=\"options_after\" value=\"#{@weekender.after}\")
    %p
      %input(type=\"submit\" value=\"submit\")
    %div.weekender= @weekender.display
"
end

template :layout do
"
!!! XML
!!!
%html(xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\" xml:lang=\"en\")
  %head
    %title weekender
  %body
    =yield
"
end
