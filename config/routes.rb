Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/home" => "welcome#index"
  get "/about" => "welcome#about_me"
  get "/contact"=> "contact#new", as: :new_contact
  post "/contact"=> "contact#create", as: :contact

  resources :sessions, only: [:new, :create] do
  delete :destroy, on: :collection
  end

  root "welcome#index"

  resources :products do
    resources :reviews, only: [:create, :destroy, :show]
  end
  resources :users, only: [:new, :create]
end
