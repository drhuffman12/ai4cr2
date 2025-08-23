require "spec"
require "faker"
require "../src/ai4cr2"
require "../spec_helpers/test_helper"

def puts_debug(message = "")
  puts message if ENV.has_key?("DEBUG") && ENV["DEBUG"] == "1"
end
