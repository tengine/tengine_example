require 'simplecov'
SimpleCov.start if ENV["COVERAGE"]

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'tengine_job'
require 'tengine_resource'
require 'mongoid'

# http://bugs.ruby-lang.org/issues/5725
require 'coverage'
class << Coverage
  alias original_result result
  def result
    original_result.inject({}) {|r, (k, v)|
      x = k.dup.force_encoding(Encoding.default_external).freeze
      r.update x => v
    }
  end
end

ENV["RACK_ENV"] ||= "test" # used in Mongoid.load!
Mongoid.load!(File.expand_path('mongoid.yml', File.dirname(__FILE__)))

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Tengine::Core::MethodTraceable.disabled = true
require 'logger'
log_path = File.expand_path("../tmp/test.log", File.dirname(__FILE__))
Tengine.logger = Logger.new(log_path)
Tengine.logger.level = Logger::DEBUG
Tengine::Core.stdout_logger = Logger.new(log_path)
Tengine::Core.stdout_logger.level = Logger::DEBUG
Tengine::Core.stderr_logger = Logger.new(log_path)
Tengine::Core.stderr_logger.level = Logger::DEBUG

Tengine::Core::Kernel.event_exception_reporter = :raise_all
Tengine::Core::Config::Core::Tengined.default_cache_drivers = true

RSpec.configure do |config|
  
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
