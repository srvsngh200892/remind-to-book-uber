class ApiLog < ActiveRecord::Base

	def self.create_logs(args)
		ApiLog.create(args)
	end	

	def self.all_logs
		ApiLog.all.order("id DESC").map(&:logs)
	end	

end	