Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # get 'boards' => 'boards#index'
  # get 'boards/new' => 'boards#new'
  # post 'boards' => 'boards#create'
  # get 'boards/:id' => 'boards#show'
  # get 'boards/:id/edit' => 'boards#edit'
  # put 'boards/:id' => 'boards#update'
  # delete 'boards/:id' => 'boards#destroy'
  # ↑resourcesを使わない書き方
  
  # resources :boards
  # ↑ 単体のresources

  resources :boards do
    resources :comments, only: [:create, :destroy]
  end
  # ↑ commentsをboardsの中に入れ子にした

  root 'boards#index'

  

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, :only => [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'dengonban', to: 'dengonban#index'
  post 'dengonban', to: 'dengonban#index'
  get 'dengonban/index'
  post 'dengonban/index'


end

  