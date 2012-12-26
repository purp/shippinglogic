$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'shippinglogic'
begin; require 'ruby-debug'; rescue LoadError; end
require 'fakeweb'

SPEC_ROOT = File.dirname(__FILE__).freeze
require SPEC_ROOT + "/lib/interceptor"

Shippinglogic::FedEx.options[:test] = true
Shippinglogic::USPS.options[:test] = true
Shippinglogic::UPS.options[:test] = true

