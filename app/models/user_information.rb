class UserInformation < ActiveRecord::Base

	validates :source_lat,:source_lng, :des_lng, :des_lng, :email, :time_to_reach, presence: true


  #schedule_job
  #author: job
	def schedule_job
    #check wheather we can remind user or not 
    #condition check if we have no time to remind user
    if self.time_to_reach - Time.zone.now <= 0.hours || (self.time_to_reach - Time.zone.now)<= self.kms.minutes
       
      #shoot email saying its too late to book an uber
      #send email
      details = {"email"=> self.email}
      CommunicationWorker.perform_async("sorry",details)
      self.email_sent = 1
      self.save
    
    #worst case
    #we take max diviation of 60 mintues + 20.minutes cab time. if condition return true we start ping before 2 hours ~ 1hour
    #this will save number of ping
		elsif ((self.time_to_reach - (self.kms.minutes + APP_CONFIG['max_diviation'].minutes)) - Time.zone.now) > APP_CONFIG['uber_cap_time'].minutes
       
      job_to_be_perform_at = (self.time_to_reach-(self.kms.minutes+APP_CONFIG['max_diviation'].minutes+APP_CONFIG['uber_cap_time'].minutes))
       # schedule job at (self.time_to_reach - (self.kms.minutes + 60.minutes)
      ApiLog.create_logs({:logs=>"Next Hit Schedule at #{job_to_be_perform_at.strftime("%d/%m/%Y @ %I:%M%P")} #{self.email}"})  
      OneTimeJob.perform_at(job_to_be_perform_at, self.id)

    else
      #schedule job which will ping google and uber to get acurate results
      IntervalJob.perform_at(0.minutes.from_now, self.id)

		end	
	end	
end