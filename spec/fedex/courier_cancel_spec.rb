require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "FedEx Courier Cancel" do
  it "should cancel the courier" do
    use_fedex_response(:courier_cancel)
    fedex = new_fedex
    cancel = fedex.courier_cancel(:confirmation_number => fedex_tracking_number, :scheduled_date => Date.today )
    lambda { cancel.perform }.should_not raise_error(Shippinglogic::FedEx::Error)
  end
end
