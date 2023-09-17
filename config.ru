require_relative "middleware/format"
require_relative "app"

use TimeFormat
run App.new 
