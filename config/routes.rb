Rails.application.routes.draw do
  resources :users, :defaults => { :format => :json } do
    resources :messages, :defaults => { :format => :json }
  end

  match '', to: 'users#create', via: [:post], :defaults => {:format => :json }
  match '', to: 'users#index', via: [:get], :defaults => {:format => :json }
  match ':id', to: 'users#show', via: [:get], :defaults => {:format => :json }
  match ':id', to: 'users#destroy', via: [:delete], :defaults => {:format => :json }
  match ':id/pubkey', to: 'users#pubkey', via: [:get], :defaults => {:format => :json }
  match ':user_id/messages', to: 'messages#index', via: [:get],  :defaults => {:format => :json }
  match 'messages', to: 'messages#create', via: [:post],  :defaults => {:format => :json }



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
