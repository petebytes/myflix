Myflix::Application.routes.draw do

  root to: 'pages#front'
  get '/home', to: 'videos#index'

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'

  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :sessions, only: [:create]

  get '/video/:id', to: 'videos#show',  as: 'video'
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end

  resources  :categories

  get 'ui(/:action)', controller: 'ui'

end
