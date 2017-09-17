Rails.application.routes.draw do
  root 'sessions#index'
  resources :users, only: [:index, :new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :plants

end
