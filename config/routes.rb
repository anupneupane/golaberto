def scope_for_locales(&block)
  locales_to_scope = I18n.available_locales - [ I18n.default_locale.to_s ]
  scope ":locale", :constraints => { :locale => Regexp.new(locales_to_scope.join("|")) } do
    yield
  end
  scope :defaults => { :locale => I18n.default_locale } do
    yield
  end
end
Golaberto::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  root :to => 'home#index'
  scope_for_locales do
  get '/' => "home#index"

  # map championship actions
  match 'championship/show/:id/phases/:phase' => 'championship#phases', via: :get
  match 'championship/show/:id/phases/:phase/team_json/' => 'championship#team_json', via: :get
  match 'championship/show/:id/games/:phase(/group/:group)(/round/:round)(/p/:page)' => 'championship#games', :constraints => { :page => /\d+/ }, :defaults => { :page => 1 }, via: :get
  match 'championship/show/:id/new_game/:phase' => 'championship#new_game', via: :get
  match 'championship/show/:id/team/:team' => 'championship#team', via: :get

  match 'game/list(/:type)(/cat/:category)(/p/:page)' => 'game#list', :constraints => { :page => /\d+/ }, :defaults => { :type => :scheduled, :page => 1, :category => 1 }, via: :get
  match 'game/list/played(/:type)(/cat/:category)(/p/:page)' => 'game#list', :constraints => { :page => /\d+/ }, :defaults => { :type => :played, :page => 1, :category => 1 }, via: :get

  match 'team/games/:type/:id(/cat/:category)(/p/:page)' => 'team#games', :constraints => { :page => /\d+/ }, :defaults => { :category => 1, :page => 1 }, via: :get

  # Install the default route as the lowest priority.
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post, :patch]
  end
end
