Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :products

    get 'demo_partials/new'
    get 'demo_partials/edit'
    get 'static_pages/home'
    get 'static_pages/help'
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: :show
    # Defines the root path route ("/")
    root "static_pages#home"
  end
end
