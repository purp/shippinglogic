require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "FedEx Courier Dispatch" do
  before(:each) do
    fedex = new_fedex
    @courier_dispatch = fedex.courier_dispatch(
      :building_description => 'HERE', 
      :company_close_time => '17:00:00-00:00', 
      :ready_time => DateTime.now, 
      :package_count => 1, 
      :package_location => 'NONE',
      :building_part_code => "BUILDING", 
      :total_weight => 1,
      :pickup_name =>"Jay",
      :pickup_title => "YO",
      :pickup_company_name =>"Vermonster",
      :pickup_phone_number =>"6176801421",
      :pickup_email =>"jay@vermonster.com",
      :pickup_streets =>"71 Broad St",
      :pickup_city =>"Boston",
      :pickup_state =>"MA",
      :pickup_postal_code =>"02109",
      :pickup_country =>"US"
    )
  end
  
  
  it "should request a courier" do
    use_fedex_response(:courier_dispatch_defaults)
    @courier_dispatch.location.should == 'LWMA'
    @courier_dispatch.confirmation == 11
  end
end

