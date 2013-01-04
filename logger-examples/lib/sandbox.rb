require 'logging'
require File.expand_path('../logging/appenders/rest.rb', __FILE__)

logger = Logging.logger['example_logger']
logger.add_appenders(
    Logging.appenders.stdout,
    Logging.appenders.rest('foobar'),
)
logger.level = :debug

logger.debug "this debug message will not be output by the logger"
logger.info "just some friendly advice"

