module Logging
  module Appenders
    # Accessor / Factory for the Rest appender.
    #
    def self.rest( *args )
      return ::Logging::Appenders::Rest if args.empty?
      ::Logging::Appenders::Rest.new(*args)
    end

    class Rest < ::Logging::Appender

      def initialize( name, opts = {} )
        super(name, opts)
      end

      def write( event )
        str = event.instance_of?(::Logging::LogEvent) ?
            layout.format(event) : event.to_s
        return if str.empty?
        puts ">>> #{str}"
      end
    end
  end
end