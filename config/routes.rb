Rails.application.routes.draw do
  devise_for :users
  
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: "home#index"
end
