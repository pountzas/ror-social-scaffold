Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get 'invitations/update'
  get 'invitations/create'
  delete 'invitations/destroy/:id', to: 'invitations#destroy', as: 'invitations_destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
    resources :posts, only: [:index]
    resources :comments, only: [:show]
  end
end
