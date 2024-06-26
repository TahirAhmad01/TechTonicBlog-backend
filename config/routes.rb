Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, path: 'users', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      }, controllers: {
        sessions: 'sessions',
        registrations: 'registrations'
      }

      resources :users, only: [:show]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      root to: 'home#index', as: "api_home"
      resources :blogs do
        post 'search', on: :collection, action: :search
        get 'viewed_blogs', on: :collection, action: :viewed_blog
        # get ':id/:slug', on: :collection, action: :show, as: :show_by_slug
        resources :comments
      end
      resource :featured_blog
      resources :tags
      resources :categories
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end