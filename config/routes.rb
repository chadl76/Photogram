Rails.application.routes.draw do
  

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user

  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index' 
  resources :posts do 
    member do 
      get 'like'
      get 'unlike'
    end
  	resources :comments
  end

  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile

  patch ':username/edit', to: 'profiles#update', as: :update_profile
end
