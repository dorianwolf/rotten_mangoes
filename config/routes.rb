RottenMangoes::Application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  namespace :admin do
    resources :users do
      get  :switch
    end
  end

  resources :users do
    get :switch_back
  end
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'

end
