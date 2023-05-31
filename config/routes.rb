Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/welcome', to: 'home#index'
  post '/articles', to: 'articles#create'
  get '/articles/new', to: 'articles#new'
  # la ruta /article/new no funcionara si no creamos primero la ruta /article, dará ERROR: Missing :controller key on routes definition, please... porque 
end
