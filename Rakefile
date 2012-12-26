require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "shippinglogic"
    gem.summary = "A simple and clean library to interface with shipping carriers"
    gem.description = "Easily use FedEx, UPS, USPS web services with an elegant and simple syntax."
    gem.email = "bjohnson@binarylogic.com"
    gem.homepage = "http://github.com/binarylogic/shippinglogic"
    gem.authors = ["Ben Johnson of Binary Logic"]
    gem.add_development_dependency "rspec", ">= 2.1.0"
    gem.add_development_dependency "fakeweb"
    gem.add_dependency "httparty", ">= 0.4.4"
    gem.add_dependency "builder", ">= 2.1.2"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec
