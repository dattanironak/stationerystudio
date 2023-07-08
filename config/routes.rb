Rails.application.routes.draw do
  root "admin/products#index"
  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
    }
  namespace :admin do 
    resources :products do 
      get '/page/:page', action: :index, on: :collection
    end
    get "orders/:status", to: "orders#index", as: :orders
  end
  
end
