Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "about_us", to: "about#index", as: "about"
  get root to: "main#index"

  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"

  delete "logout", to: "session#destroy"

  get "login", to: "session#new"
  post "login", to: "session#create"

  get "password", to: "password#edit", as: "edit_password"
  patch "password", to: "password#update"

  get "password/reset", to: "password_reset#new"
  post "password/reset", to: "password_reset#create"

  get "password/reset/edit", to: "password_reset#edit"
  patch "password/reset/edit", to: "password_reset#update"

  get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"

  resources :twitter_accounts

  resources :tweets
  
end
