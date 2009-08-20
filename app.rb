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
  %form{:method => 'get', :action => '/'}
    - ['year', 'month', 'day', 'before', 'after'].each do |method|
    - id    = 'options_' + method
    - name  = 'options[' + method + ']'
    - value = @weekender.send(method.to_sym)
    - label = (method == 'before' || method == 'after') ? 'number of weeks ' + method : method
      %p
        %label{:for => id}= label
        %br
        %input{:type => 'text', :name => name, :id => id, :value => value}
    %p
      %input{:type => 'submit', :value => 'submit'}
    %div.weekender= @weekender.display
"
end

template :layout do
"
!!! XML
!!!
%html{:xmlns => 'http://www.w3.org/1999/xhtml', :lang => 'en', 'xml:lang' => 'en'}
  %head
    %title weekender
  %body
    =yield
"
end
