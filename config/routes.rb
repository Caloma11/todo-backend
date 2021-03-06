Rails.application.routes.draw do
  devise_for :users
  delete "api/v1/notes/bulk", to: "api/v1/notes#bulk_destroy", as: :bulk_destroy
  root to: 'pages#home'
    namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post :auth, to: "authentication#create"
      resources :notes, except: [:show]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
