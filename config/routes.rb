Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:index, :create, :destroy]

  # resources :blogs, only: [:new, :create, :edit, :destroy]
  resources :blogs do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update]
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
