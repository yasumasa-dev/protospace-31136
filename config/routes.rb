Rails.application.routes.draw do
  devise_for :users
  root to:'prototypes#index'
  resources :users, only: :show
  resources :prototypes, only: [ :show, :new, :create, :destroy, :edit, :update] do
    resources :comments, only: :create
  end
  post '/prototypes/:id' => 'prototypes#create'
end