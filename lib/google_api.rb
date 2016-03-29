module GoogleApi

	def self.get_time_to_travel(s_lat, s_lng, d_lat, d_lng, email, without_traffic=false)
		current_time = (Time.now+2.seconds).to_time.to_i
  	url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="+s_lat.to_s+","+s_lng.to_s+"&destinations="+d_lat.to_s+","+d_lng.to_s+"&key="+APP_CONFIG['app_key'].to_s+"&transit_mode=car&language=en&departure_time="+current_time.to_s
    response = ApiModule.admin_api_get_call(url, {})
    ApiLog.create_logs({:logs=>"#{Time.zone.now.strftime("%d/%m/%Y @ %I:%M%P")} Hit goes to google api for #{email}"})
		if response.code != 200
			res = JSON.parse response if response && response.exclude?("xml")
		else
			res = JSON.parse response
			if res["rows"][0]["elements"][0]["status"].present? and res["rows"][0]["elements"][0]["status"] != "OK"
				return -1
			else
				duration_in_traffic = res["rows"][0]["elements"][0]["duration_in_traffic"]["value"]/60
				duration = res["rows"][0]["elements"][0]["duration"]["value"]/60
        time = without_traffic ? duration : duration_in_traffic
				return time 
			end	
		end	
  end
   
end


