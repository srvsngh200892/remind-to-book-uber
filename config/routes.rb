UberApp::Application.routes.draw do

  get '/' => redirect("remind_cabs/remind_me")

  
  require 'sidekiq/web'
  
  if Rails.env == 'production'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  else
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :remind_cabs do
    collection do
      get 'remind_me'
    end
  end  

end
