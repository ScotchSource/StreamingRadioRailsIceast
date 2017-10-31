Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :songs, only: %i[new create index]

  root 'pages#index'
end
