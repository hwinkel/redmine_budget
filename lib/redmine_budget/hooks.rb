module RedmineBudget
  class Hooks < Redmine::Hook::ViewListener
              
    render_on :view_projects_show_sidebar_bottom,
              :partial => 'hooks/budget/sidebar'
              
    render_on :view_projects_show_right,
              :partial => 'hooks/budget/view_projects_show_right'
    
  end
end