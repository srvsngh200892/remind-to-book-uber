class IntervalJob
  include Sidekiq::Worker
  def perform(id)

    user_data = UserInformation.find(id)

    return if user_data.email_sent == 1
    
    pickup_estimate = UberApi.get_uber_pickup(user_data.source_lat, user_data.source_lng)

    time_estimate = GoogleApi.get_time_to_travel(user_data.source_lat, user_data.source_lng , user_data.des_lat, user_data.des_lng, user_data.email)
    
    
    if ((user_data.time_to_reach - (time_estimate.minutes + pickup_estimate.seconds)) - Time.zone.now) < 0.minutes

      details = {"email"=> user_data.email}
      CommunicationWorker.perform_async("sorry",details)
      user_data.email_sent = 1
      user_data.save

    elsif ((user_data.time_to_reach - (time_estimate.minutes + pickup_estimate.seconds)) - Time.zone.now) < 5.minutes
        
        #send email
        details = {"email"=> user_data.email}
        CommunicationWorker.perform_async("time_to_book",details)
        user_data.email_sent = 1
        user_data.save
    else
      IntervalJob.perform_at(Time.zone.now+1.minutes, user_data.id)
    end  
    
  end
end