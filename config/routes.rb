Rails.application.routes.draw do
  root 'posts#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources 'sessions'
  resources 'posts', only:[:new,:create,:index]
  resources 'users', only:[:new,:create,:show]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
