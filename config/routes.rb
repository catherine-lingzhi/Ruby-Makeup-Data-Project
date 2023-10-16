Rails.application.routes.draw do
  get "about", to: "about#index"
  root "products#index"
  resources :products, only: %i[index show] do
    collection do
      get "search", to: "products#search"
    end
  end

  resources :categories, only: %i[index show]
  resources :tags, only: %i[index show]
  resources :brands, only: %i[index show]
end
