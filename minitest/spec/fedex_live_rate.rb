require 'minitest/autorun'
require 'shippinglogic'
require './minitest/fedex_helper'

describe "FedEx Rate Live" do
  before do
    @fedex = new_fedex
  end
  
  it "should rate the shipment" do
    
    rates = @fedex.rate(shipper.merge(recipient).merge(package))
    
    rates.size.must_equal 6
    
    rate = rates.first
    rate.name.must_equal "First Overnight"
    rate.type.must_equal "FIRST_OVERNIGHT"
    rate.saturday.wont_equal true
    rate.speed.must_equal 86400 # 1.day
    rate.rate.wont_be '<' , 70.00
    rate.currency.must_equal "USD"
  end

  it "should not require dimensions when not using custom packaging" do
    
    rates = @fedex.rate(shipper.merge(recipient).merge(:packaging_type =>"FEDEX_ENVELOPE", :package_weight => 0.1))
    
    rates.size.must_equal 5
    
    rate = rates.first
    rate.name.must_equal "First Overnight"
    rate.type.must_equal "FIRST_OVERNIGHT"
    rate.saturday.wont_equal true
    rate.speed.must_equal 86400 # 1.day
    rate.rate.wont_be '<' , 50.00
    rate.currency.must_equal "USD"
  end
  
  it "should rate an international shipment" do
    
    rates = @fedex.rate(shipper.merge(international_recipient).merge(package))
    
    rates.size.must_equal 3
    
    rate = rates.first
    rate.name.must_equal "International Priority"
    rate.type.must_equal "INTERNATIONAL_PRIORITY"
    rate.saturday.wont_equal true
    rate.speed.must_equal 259200 # 3 days
    rate.rate.wont_be '<' , 70.00
    rate.currency.must_equal "USD"
  end
end


