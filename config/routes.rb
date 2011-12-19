Pulsar::Application.routes.draw do
  match 'events/report' => 'events#report'
  match 'notification' => 'events#notification'

  match 'report' => 'events#report'
  match 'report/onHumanOut' => 'events#report'
  match 'report/onHumanIn' => 'events#report'
  match 'triggers/notification' => 'triggers#notification'
  match 'zones' => 'visualizations#stoplights'
  match 'zones/data' => 'zones#data'
  match 'triggers' => 'triggers#all'
  match 'triggers/new' => 'triggers#new', :via => :get
  match 'triggers/new' => 'triggers#create', :via => :post
  
  match 'triggers/view/:id' => 'triggers#view'
  match 'triggers/delete/:id' => 'triggers#delete'
  match 'home' => 'triggers#menu'
  match 'energy' => 'energy#all'
  
  match 'entities' => 'entities#all'
  
match 'liveSynergy/demo-booth/fan' => 'entities#fan'
match 'liveSynergy/demo-booth/lcd-monitor' => 'entities#lcdmonitor'
match 'liveSynergy/demo-booth/light' => 'entities#light'
match 'liveSynergy/demo-booth' => 'entities#demobooth'
	
match 'liveSynergy/demo-booth/fan/energy' => 'energy#fan'
match 'liveSynergy/demo-booth/lcd-monitor/energy' => 'energy#lcdmonitor'
match 'liveSynergy/demo-booth/light/energy' => 'energy#light'
match 'liveSynergy/demo-booth/energy' => 'energy#demobooth'

match 'liveSynergy/demo-booth/fan/energy/data' => 'energy#fandata'
match 'liveSynergy/demo-booth/lcd-monitor/energy/data' => 'energy#lcdmonitordata'
match 'liveSynergy/demo-booth/light/energy/data' => 'energy#lightdata'
match 'liveSynergy/demo-booth/energy/data' => 'energy#demoboothdata'

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
  # match ':controller(/:action(/:id(.:format)))'
end
