def shipper
  {
    :shipper_name         => "Name",
    :shipper_title        => "Title",
    :shipper_company_name => "Company",
    :shipper_phone_number => "2222222222",
    :shipper_email        => "a@a.com",
    :shipper_streets      => "260 Broadway",
    :shipper_city         => "New York",
    :shipper_state        => "NY",
    :shipper_postal_code  => "10007",
    :shipper_country      => "US"
  }
end

def recipient
  {
    :recipient_name         => "Name",
    :recipient_title        => "Title",
    :recipient_department   => "Department",
    :recipient_company_name => "Dallas City Hall",
    :recipient_phone_number => "2222222222",
    :recipient_email        => "a@a.com",
    :recipient_streets      => "1500 Marilla Street",
    :recipient_city         => "Dallas",
    :recipient_state        => "TX",
    :recipient_postal_code  => "75201",
    :recipient_country      => "US"
  }
end

def international_recipient
  {
    :recipient_name         => "Name",
    :recipient_title        => "Title",
    :recipient_department   => "Department",
    :recipient_company_name => "Metrotown Centre",
    :recipient_phone_number => "4444444444",
    :recipient_email        => "international@example.com",
    :recipient_streets      => "4800 Kingsway",
    :recipient_city         => "Burnaby",
    :recipient_state        => "BC",
    :recipient_postal_code  => "V5H4J2",
    :recipient_country      => "CA"
  }
end

def package
  {
    :package_weight => 2,
    :package_length => 2,
    :package_width  => 2,
    :package_height => 2
  }
end
def new_fedex
  Shippinglogic::FedEx.new(*fedex_credentials.values_at("key", "password", "account", "meter"))
end

def fedex_credentials
  return @fedex_credentials if defined?(@fedex_credentials)

  fedex_credentials_path = "config/fedex_credentials.yml"

  unless File.exists?(fedex_credentials_path)
    raise "You need to add your own FedEx test credentials in config/fedex_credentials.yml. See config/fedex_credentials.example.yml for an example."
  end

  @fedex_credentials = YAML.load(File.read(fedex_credentials_path))
end

Shippinglogic::FedEx.options[:test] = true
