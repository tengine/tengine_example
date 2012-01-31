require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

begin
  require 'jeweler'
rescue LoadError
  # nothing
else
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "tengine_example"
    gem.homepage = "http://github.com/shyouhei/tengine_example"
    gem.license = "LGPL or MPL"
    gem.summary = "Tengine framework examples and deployer"
    gem.description = "Tengine framework examples and deployer"
    gem.email = "shyouhei@ruby-lang.org"
    gem.authors = ["Urabe, Shyouhei"]
    # dependencies defined in Gemfile
  end
  Jeweler::RubygemsDotOrgTasks.new

  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
  end

  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
  end

  task :default => :spec

  require 'yard'
  YARD::Rake::YardocTask.new

  Rake::Task[:console].clear_actions # Delete jeweler's "rake console"
end

task :console, [:config] do |c, argh|
  require 'bundler/setup'
  require 'irb'
  require 'mongoid'
  require 'amqp'
  require 'tengine_job'
  require 'tengine_resource'

  config = Tengine::Core::Config::Core.parse argh[:config] || 'config/tengined.yml.erb'
  config.setup_loggers

  Mongoid.config.from_hash config[:db]
  Mongoid.config.option :persist_in_safe_mode, :default => true
  Mongoid.logger = AMQP::Session.logger = Tengine.logger

  ARGV.clear
  IRB.start
end

namespace :daemons do
  daemons = {
    tengined: %w'tengined tengined.yml.erb',
    heartbeat_watchd: %w'tengine_heartbeat_watchd heartbeat_watchd.yml.erb',
    resource_watchd: %w'tengine_resource_watchd resource_watchd.yml.erb',
    atd: %w'tengine_atd atd.yml.erb',
  }

  daemons.each_pair do |x, (y, z)|
    namespace x do
      %w'test load start enable stop force-stop status activate'.each do |t|
        desc "tell #{x} to process request of: #{t}"
        task t.intern do
          sh "bundle exec #{y} -k #{t} -f #{Dir.getwd}/config/#{z}"
        end
      end
    end
  end

  %w'start stop force-stop status'.each do |t|
    desc "tell all daemons to process request of: #{t}"
    task t.intern do
      daemons.each_pair do |x, (y, z)|
        sh "bundle exec #{y} -k #{t} -f #{Dir.getwd}/config/#{z}"
      end
    end
  end
end

# 
# Local Variables:
# mode: ruby
# coding: utf-8-unix
# indent-tabs-mode: nil
# tab-width: 4
# ruby-indent-level: 2
# fill-column: 79
# default-justification: full
# End:
