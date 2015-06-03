# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "TwilioCallHandler"
  spec.version       = '1.0'
  spec.authors       = ["Kyle Thompson"]
  spec.email         = ["kyle@kylekthompson.com"]
  spec.summary       = %q{Call handler for Twilio phone numbers.}
  spec.description   = %q{Creates TwiML for Twilio phone numbers to read.}
  spec.homepage      = "N/A"
  spec.license       = "GNU GPL"

  spec.files         = ['lib/TwilioCallHandler.rb']
  spec.executables   = ['bin/TwilioCallHandler']
  spec.test_files    = ['tests/test_TwilioCallHandler.rb']
  spec.require_paths = ["lib"]
end
