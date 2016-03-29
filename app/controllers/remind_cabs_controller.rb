class RemindCabsController < ApplicationController

	def remind_me
		@user_data = UserInformation.new
	end

	#save user info and get google time to reach des without traffic and schedule the job

  #author: saurav
  
  def create

		@user_data = UserInformation.new(user_params)
		duration = GoogleApi.get_time_to_travel(user_params[:source_lat], user_params[:source_lng], user_params[:des_lat], user_params[:des_lng], user_params[:email], true)
    @user_data.kms = duration
    respond_to do |format|
      if duration != -1 and @user_data.save
      	@user_data.schedule_job
        format.html { redirect_to '/remind_cabs/remind_me', notice: 'We will remind you to book an uber through an email' }
        format.json { render action: 'show', status: :created, location: @user_data}
      else
        format.html { render action: 'remind_me' } if duration!=-1
        format.html { redirect_to '/remind_cabs/remind_me', notice: 'Sorry lat or lng not valid' } if duration==-1
        format.json { render json: @user_data.errors, status: :unprocessable_entity }
      end
    end
	end

	private

	def user_params
    user_params = params.require(:user_information).permit!()
  end
end
