Rails.application.routes.draw do
  resources :songs, only: %i[new create index]

  root 'pages#index'
end
