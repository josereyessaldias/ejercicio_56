Rails.application.routes.draw do

  resources :collections, only: [:show]
  resources :user, only: [:show]
  resources :activities, only: [:create, :new, :show, :edit, :update]
  resources :user_activities, only: [:create, :edit, :update, :destroy]
  resources :contacts, only: [:create, :destroy]
  resources :promote_activities, only: [:new, :create, :show, :destroy]


  get 'pages/index'
  get 'pages/politica'

  get 'user_calendar/:user_id', to: 'pages#user_calendar', as: 'user_calendar'
  patch 'edit_calendar/:activity_id', to: 'user_activities#update_calendar', as: 'update_user_calendar'
  
 

  resources :billings, only: [:index] do
    collection do
      get 'pre_pay'
      get 'execute'
    end
  end

  devise_for :users, controllers: {
        :omniauth_callbacks => "user/omniauth_callbacks",
        registrations: 'user/registrations'
      }

  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
