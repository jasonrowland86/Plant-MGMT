Rails.application.routes.draw do
  root 'sessions#index'
  resources :users, only: [:index, :new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  get '/plants/wet' => 'plants#wet'
  get '/plants/medium' => 'plants#medium'
  get '/plants/dry' => 'plants#dry'
  resources :plants

end
