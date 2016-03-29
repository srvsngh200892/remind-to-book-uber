require 'rubygems'

class CommunicationWorker

	include Sidekiq::Worker
	sidekiq_options :retry => false, :queue => :communication
    
  def perform(args, details)
    RemindMailer.send(args,details).deliver
  end
end