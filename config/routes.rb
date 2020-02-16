Rails.application.routes.draw do
  post 'customer_token' => 'customer_token#create'
  resources :invoices
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
