Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome', to: 'home#index'
  root to: 'home#index'
  # la ruta /article/... no funcionara si no creamos primero la ruta /article, dará ERROR: Missing :controller key on routes definition, please... porque 

  resources :articles do
    get "user/:user_id", to: "articles#from_author", on: :collection
  end
  #todas las lineas siguientes, se generan con resources.

  # get 'articles', to:'articles#index'
  # post 'articles', to: 'articles#create'
  # get 'articles/new', to: 'articles#new', as: :new_articles
  # get 'articles/:id', to: 'articles#show'
  # get 'articles/:id/edit', to: 'articles#edit'
  # # patch '/articles/:id', to: 'articles#update', as: article
  # post 'articles', to: 'articles#create'
  # delete '/articles/:id', to:  'articles#destroy'
end