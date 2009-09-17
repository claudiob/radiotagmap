# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiotagmap}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Claudio Baccigalupo"]
  s.date = %q{2009-09-18}
  s.description = %q{Radiotagmap reads from Yes.com the songs that are currently playing in FM radios, then extracts the most played tag/genre in every U.S. state and returns a KML representation of this data, which can be plotted on a map using Google Maps or Google Earth.}
  s.email = %q{claudiob@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "features/radiotagmap.feature",
     "features/step_definitions/radiotagmap_steps.rb",
     "features/support/env.rb",
     "lib/radiotagmap.rb",
     "radiotagmap.gemspec",
     "test/radiotagmap_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/claudiob/radiotagmap}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby gem to map by U.S. state the music played on FM radios}
  s.test_files = [
    "test/radiotagmap_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<claudiob-yesradio>, [">= 0.1.2"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.3.2"])
      s.add_runtime_dependency(%q<scrobbler>, [">= 0.2.3"])
    else
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<claudiob-yesradio>, [">= 0.1.2"])
      s.add_dependency(%q<nokogiri>, [">= 1.3.2"])
      s.add_dependency(%q<scrobbler>, [">= 0.2.3"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<claudiob-yesradio>, [">= 0.1.2"])
    s.add_dependency(%q<nokogiri>, [">= 1.3.2"])
    s.add_dependency(%q<scrobbler>, [">= 0.2.3"])
  end
end
