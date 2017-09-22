Rails.application.routes.draw do
  resources :events
  root 'sessions#index'
  resources :users

  resource :session, only: [:new, :create, :destroy]

  get '/plants/dashboard' => 'plants#dashboard'
  get '/plants/wet' => 'plants#wet'
  get '/plants/moderate' => 'plants#moderate'
  get '/plants/dry' => 'plants#dry'
  resources :plants

  resources :events do
    resources :exceptions, module: :events
  end

end
