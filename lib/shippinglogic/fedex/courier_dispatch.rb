module Shippinglogic
  class FedEx
    class CourierDispatch < Service
      class CourierDispatch; attr_accessor :confirmation, :location; end
      
      # Interface to accessing FedEx's courier requst service
      #
      # == Options
      # :use_account_address - true/false (default: true)
      attribute :pickup_name,                 :string
      attribute :pickup_title,                :string
      attribute :pickup_company_name,         :string
      attribute :pickup_phone_number,         :string
      attribute :pickup_email,                :string
      attribute :pickup_streets,              :string
      attribute :pickup_city,                 :string
      attribute :pickup_state,                :string
      attribute :pickup_postal_code,          :string
      attribute :pickup_country,              :string,      :modifier => :country_code
      attribute :pickup_residential,          :boolean,     :default => false

      attribute :use_account_address,         :boolean,     :default => true
      attribute :package_location,            :string
      attribute :package_weight_units,        :string,      :default => "LB"
      attribute :package_count,               :integer,     :default => 1
      attribute :total_weight,                :integer
      attribute :building_part_code,          :string
      attribute :building_description,        :string
      attribute :ready_time,                  :datetime
      attribute :company_close_time,          :datetime
      attribute :carrier_code,                :string,      :default => "FDXE"
      attribute :oversize_package_count,      :integer,     :default => 0
      attribute :courier_remarks,             :string,      :default =>''      
      attribute :commodity_description,       :string,      :default => ''
      
      

      VERSION = {:major => 3, :intermediate => 0, :minor => 0 }
      
      private

      def target
        @target ||= parse_response(request(build_request))
      end

      def build_request
        b = builder
        xml = b.CourierDispatchRequest(:xmlns => "http://fedex.com/ws/courierdispatch/v#{VERSION[:major]}") do
          build_authentication(b)
          build_version(b, "disp", VERSION[:major], VERSION[:intermediate], VERSION[:minor])
           b.OriginDetail do
             b.UseAccountAddress use_account_address
             b.PickupLocation do
               build_contact(b, :pickup)
               build_address(b, :pickup)
             end
             b.PackageLocation package_location
             b.BuildingPartCode building_part_code
             b.BuildingPartDescription building_description
             b.ReadyTimestamp ready_time
             b.CompanyCloseTime company_close_time
          end
          b.PackageCount package_count
          b.TotalWeight do
            b.Units package_weight_units
            b.Value total_weight
          end
          b.CarrierCode carrier_code
          b.OversizePackageCount oversize_package_count
          b.CourierRemarks courier_remarks
          b.CommodityDescription commodity_description
        end
      end
      
      def parse_response(response)
        courier_dispatch = CourierDispatch.new
        courier_dispatch.confirmation = response[:dispatch_confirmation_number]
        courier_dispatch.location = response[:location]
        courier_dispatch
      end
    end
  end

end
