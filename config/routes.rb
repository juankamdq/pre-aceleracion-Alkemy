Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 
  
  
  resources :genres, except: [:show]

  resources :characters, except: [:show, :edit]
  get '/characters/details', to: "characters#detail" 

  resources :movies, except: [:show]
  get '/movies/details', to: "movies#detail"

  resources :users, only: [:create]
  post '/login', to: "users#login"
  post '/auto_log', to: "users#auto_log"
end
