module UberApi

  def self.get_uber_pickup(s_lat, s_lng, email)
    url = "https://api.uber.com/v1/estimates/time?start_latitude="+s_lat.to_s+"&start_longitude="+s_lng.to_s+"&product_id=db6779d6-d8da-479f-8ac7-8068f4dade6f"
    response = ApiModule.admin_api_get_call(url, {},  APP_CONFIG['sever_token'])
    ApiLog.create_logs({:logs=>"#{Time.zone.now.strftime("%d/%m/%Y @ %I:%M%P")} Hit goes to Uber api for #{email}"})
    if response.code != 200
      res = JSON.parse response if response && response.exclude?("xml")
    else
      res = JSON.parse response
      if res["times"].present?
        return res["times"][0]["estimate"]
      else
        return 0
      end
    end 
  end
   
end