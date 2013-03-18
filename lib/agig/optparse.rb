require 'optparse'

module Agig::OptParser
  def self.parse!(argv)
    opts = {
      port: 16705,
      host: 'localhost',
      log: nil,
      debug: false,
      daemonize: false,
    }

    OptionParser.new do |parser|
      parser.instance_eval do
        self.banner  = "Usage: #{$0} [opts]"
        separator ""

        separator "Options:"
        on("-p", "--port [PORT=#{opts[:port]}]", "port number to listen") do |port|
          opts[:port] = port
        end

        on("-h", "--host [HOST=#{opts[:host]}]", "host name or IP address to listen") do |host|
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
