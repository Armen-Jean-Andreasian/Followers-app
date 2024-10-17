Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :subscriptions

  resources :posts do
    resources :comments, only: [:show, :create, :edit, :update, :destroy]
  end

  namespace :users do
    resources :subscriptions, only: [:index, :show]
    resources :posts do
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
  end

  root "posts#index"
end
