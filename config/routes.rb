ActionController::Routing::Routes.draw do |map|

  map.resources :users

  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about '/about', :controller => 'pages', :action => 'about'
  map.help '/help', :controller => 'pages', :action => 'help'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.root :controller => 'pages', :action => 'home'
  
  #defaults
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
