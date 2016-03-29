if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
      :address              => "localhost",
      :port                 => 1025,
      :address              => "saurav200892@gmail.com",
      :port                 => 587,
      :user_name            => "saurav200892@gmail.com",
      :password             => "comingsoon",
      :authentication       => "plain",
      :enable_starttls_auto => true
  }
end