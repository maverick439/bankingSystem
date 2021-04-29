Rails.application.routes.draw do
  resources :transactions do
    collection do
      post "credit_money"
      post "debit_money"
    end
  end
  resources :accounts do
    collection do
      get "get_account_transaction_history"
    end
  end
  resources :roles
  resources :users
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
