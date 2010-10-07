module Shippinglogic
  class FedEx

    class CourierCancel < Service
      VERSION = {:major => 3, :intermediate => 0, :minor => 0 } 

      attribute :carrier_code,          :string,      :default => "FDXE"
      attribute :confirmation_number,   :string
      attribute :scheduled_date,        :date
      attribute :location,              :string
      attribute :courier_remarks,       :string

      def perform
        target && true
      end

    private

      def target
        @target ||= request(build_request)
      end

      def build_request
        b = builder
        xml = b.CancelCourierDispatchRequest(:xmlns => "http://fedex.com/ws/courierdispatch/v#{VERSION[:major]}") do
          build_authentication(b)
          build_version(b, "disp", VERSION[:major], VERSION[:intermediate], VERSION[:minor])
          b.CarrierCode carrier_code
          b.DispatchConfirmationNumber confirmation_number
          b.ScheduledDate scheduled_date
          b.Location location if location
          b.CourierRemarks courier_remarks if courier_remarks
        end
      end
    end
  end
end
