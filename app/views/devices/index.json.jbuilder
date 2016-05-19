json.array!(@devices) do |device|
  json.extract! device, :id, :code, :added
  json.url device_url(device, format: :json)
end
