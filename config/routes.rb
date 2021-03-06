Rails.application.routes.draw do
  mount LikeDislike::Engine, at: '/'
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root "static_pages#home"

  resources :users, only: [:index, :show]
  resources :locations, only: [:index, :show]
  resources :reviews
  resources :comments
  resources :votes, only: [:create, :destroy]
  resources :categories, only: :show
  namespace :admin do
    root "static_pages#home"
    resources :locations
    resources :users, only: [:index, :destroy, :show]
    resources :categories
    resources :images, only: [:new, :create]
  end
end
