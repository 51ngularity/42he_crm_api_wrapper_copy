Rails.application.routes.draw do

  resources :companies

  resources :people do
    collection do
      get :search
      post :search_result
    end
  end

  get ':controller(/:action(/:id(.:format)))'

  root to: 'companies#index'



end
