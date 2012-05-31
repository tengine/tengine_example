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

task :console, [:config] do |c, argh|
  require 'bundler/setup'
  require 'irb'
  require 'mongoid'
  require 'amqp'
  require 'tengine_job'
  require 'tengine_resource'

  config = Tengine::Core::Config::Core.parse argh[:config] || 'config/tengined.yml.erb'
  config.setup_loggers
  Tengine::Event.config = config[:event_queue]

  Mongoid.config.from_hash config[:db]
  Mongoid.config.option :persist_in_safe_mode, :default => true
  Mongoid.logger = AMQP::Session.logger = Tengine.logger

  ARGV.clear
  IRB.start
end

desc "sucks all pending events from the queue (for debug)"
task :sucks do
  sh "bundle exec tengine_event_sucks"
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
        task t.intern do
          sh "bundle exec #{y} -k #{t} -f #{Dir.getwd}/config/#{z}"
        end
      end
    end
  end

  %w'start stop force-stop status'.each do |t|
    desc "tell all daemons to process request of: #{t}"
    task t => daemons.map {|(k, v)| "#{k}:#{t}" }
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
