require_dependency 'projects_helper'

module BudgetProjectsHelperPatch
  def self.included base
    base.send :include, BudgetProjectsHelperMethods
    base.class_eval do
      alias_method_chain :project_settings_tabs, :budget
    end
  end
end

module BudgetProjectsHelperMethods
  def project_settings_tabs_with_budget
    tabs = project_settings_tabs_without_budget
    tab = {
      :name => 'budget',
      :controller => 'budget_config', :action => :show,
      :partial => 'budget_config/show', :label => :label_budget_menu_main}
    if User.current.admin? || User.current.allowed_to?(tab, @project)
      tabs.insert(1,tab) 
    end
    return tabs
  end
end

ProjectsHelper.send(:include, BudgetProjectsHelperPatch)
