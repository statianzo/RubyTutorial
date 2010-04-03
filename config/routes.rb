ActionController::Routing::Routes.draw do |map|
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about '/about', :controller => 'pages', :action => 'about'
  map.help '/help', :controller => 'pages', :action => 'help'
  map.root :controller => 'pages', :action => 'home'
  
  #defaults
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
