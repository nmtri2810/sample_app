Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :products

    get "demo_partials/new"
    get "demo_partials/edit"
    get "static_pages/home"
    get "static_pages/help"
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, except: %i(new create)
    resources :account_activations, only: :edit
    # Defines the root path route ("/")
    root "static_pages#home"
  end
end
