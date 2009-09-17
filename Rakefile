require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "radiotagmap"
    gem.summary = %Q{Ruby gem to map by U.S. state the music played on FM radios}
    gem.description = %Q{Radiotagmap reads from Yes.com the songs that are currently playing in FM radios, then extracts the most played tag/genre in every U.S. state and returns a KML representation of this data, which can be plotted on a map using Google Maps or Google Earth.}
    gem.email = "claudiob@gmail.com"
    gem.homepage = "http://github.com/claudiob/radiotagmap"
    gem.authors = ["Claudio Baccigalupo"]
    gem.add_development_dependency "cucumber"
    gem.add_dependency "claudiob-yesradio", ">=0.1.1"
    gem.add_dependency "nokogiri", ">=1.3.2"
    gem.add_dependency "scrobbler", ">=0.2.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "radiotagmap #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
