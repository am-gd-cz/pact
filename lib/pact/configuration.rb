require 'ostruct'
require 'logger'

module Pact

  class Configuration
    attr_accessor :pact_dir
    attr_accessor :log_dir
    attr_accessor :logger
    attr_accessor :tmp_dir

    def log_path
      log_dir + "/pact_gem.log"
    end
  end

  def self.configuration
    @configuration ||= default_configuration
  end

  def self.configure
    yield configuration
    FileUtils::mkdir_p configuration.tmp_dir
  end

  def self.clear_configuration
    @configuration = default_configuration
  end

  private

  def self.default_configuration
    c = Configuration.new
    c.pact_dir = File.expand_path('./spec/pacts')
    c.tmp_dir = File.expand_path('./tmp/pacts')
    c.log_dir = default_log_dir
    c.logger = default_logger c.log_path
    c
  end

  def self.default_log_dir
    File.expand_path("./log")
  end

  def self.default_logger path
    FileUtils::mkdir_p File.dirname(path)
    logger = Logger.new(path)
    logger.level = Logger::INFO
    logger
  end

end