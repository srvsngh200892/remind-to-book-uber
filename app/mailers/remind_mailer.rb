class RemindMailer < ActionMailer::Base
  default from: "Remind me <saurav200892@gmail.com>"

  def sorry(details)
		email = details.values_at("email")
		mail(to: email, subject: "Sorry you can't to book an uber to reach your destination on time")
	end

	def time_to_book(details)
		email = details.values_at("email")
		mail(to: email, subject: "Hey!! It's time to book an Uber. }")
	end
end	