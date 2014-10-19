# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
  match '/projects/:project_id/budget/settings',
    :to => 'budget_config#update', :via => :put,
    :as => 'budget_config'
    
end