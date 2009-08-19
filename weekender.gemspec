# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{weekender}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Olivier Lauzon"]
  s.date = %q{2009-08-19}
  s.email = %q{olauzon@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
    "Rakefile",
    "lib/core_ext/date.rb",
    "lib/core_ext/string.rb",
    "lib/weekender.rb",
    "lib/weekender/view_helpers.rb",
    "lib/weekender/weekender.rb",
    "spec/fixtures/weekender.html",
    "spec/spec_helper.rb",
    "spec/weekender_spec.rb"
  ]
  s.homepage = %q{http://github.com/olauzon/weekender}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A simple Ruby library for creating calendars based on weeks rather than months.}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/weekender_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
