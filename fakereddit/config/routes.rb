Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :subs 
  resources :posts, except: [:index] do 
    resources :comments, only: [:new]
  end 
  resources :comments, only: [:create, :edit, :update, :destroy, :show]
end
