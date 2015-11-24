Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/users'

  mount_devise_token_auth_for 'Manager', at: 'auth/managers'

  # now we have an api:
  namespace :api do
    namespace :external do
      namespace :v1 do
        match 'users/current', to: 'users#current', via: :get
        match 'managers/current', to: 'managers#current', via: :get      
      end

      namespace :v2 do
        # mount authorization here
        mount_devise_token_auth_for 'User', at: 'auth/users'
        mount_devise_token_auth_for 'Manager', at: 'auth/managers'
        match 'users/current', to: 'users#current', via: :get
        match 'managers/current', to: 'managers#current', via: :get 
      end

      namespace :v3 do
        match 'users/current', to: 'users#current', via: :get
        match 'managers/current', to: 'managers#current', via: :get 
      end
    end
  end

  # route unknown paths to page not found in application#page_not_found
  match '*path', to: 'application#page_not_found', via: :all
end
