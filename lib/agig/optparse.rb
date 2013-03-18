require 'optparse'

module Agig::OptParser
  DEFAULT_HOST = '127.0.0.1'
  DEFAULT_PORT = 16705

  def self.parse!(argv)
    opts = {
      host: Agig::OptParser::DEFAULT_HOST,
      port: Agig::OptParser::DEFAULT_PORT,
      log: nil,
      debug: false,
      daemonize: false,
    }

    OptionParser.new do |parser|
      parser.instance_eval do
        self.banner  = "Usage: #{$0} [opts]"
        separator ""

        separator "Options:"
        on("-p", "--port [PORT=#{opts[:port]}]", "use PORT (default: #{Agig::OptParser::DEFAULT_PORT})") do |port|
          opts[:port] = port
        end

        on("-h", "--host [HOST=#{opts[:host]}]", "listen HOST (default: #{Agig::OptParser::DEFAULT_HOST})") do |host|
          opts[:host] = host
        end

        on("-l", "--log LOG", "log file") do |log|
          opts[:log] = log
        end

        on("-d", "--debug", "enable debug mode") do
          opts[:log] = $stdout
          opts[:debug] = true
        end

        on("-D", "--daemonize", "run daemonized in the background") do
          opts[:daemonize] = true
        end

        parse!(argv)
      end
    end

    opts
  end
end
