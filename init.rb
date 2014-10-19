require 'helpers/budget_projects_helper_patch'
require 'redmine_budget/hooks'
require 'redmine_budget/patches/project_patch'

Redmine::Plugin.register :redmine_budget do
  name 'Redmine Budget plugin'
  author 'GMO RUNSYSTEM'
  description 'Project Redmine'
  version '0.0.1'
  url 'http://redmine.vn'
  author_url 'http://redmine.vn'
  
  project_module :budget do
    permission :budget_admin, {
      :budget_config => [:show, :update]
      }
  end  
  
  
  Rails.configuration.to_prepare do
    require_dependency 'projects_helper'
    unless ProjectsHelper.included_modules.include? BudgetProjectsHelperPatch
      ProjectsHelper.send(:include, BudgetProjectsHelperPatch)
    end
  end
  
end
