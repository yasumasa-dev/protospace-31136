Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  root to:'prototypes#index'
  resources :users
  resources :prototypes, only: [:new, :create] #do
    #resources :name, only: [:index, :creste]
  #end
end
