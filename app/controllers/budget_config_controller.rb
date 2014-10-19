class BudgetConfigController < ApplicationController
  unloadable
  
  before_filter :find_project_by_project_id, :authorize
  
  def update
    @budget = ProjectsBudget.find_by_project_id(@project.id)
    unless @budget
      @budget = ProjectsBudget.new
      @budget.project_id = @project.id
    end
    @budget.pm_unit = params[:pm_unit] if params.key?(:pm_unit)
    @budget.bsej_unit = params[:bsej_unit] if params.key?(:bsej_unit)
    @budget.bsev_unit = params[:bsev_unit] if params.key?(:bsev_unit)
    @budget.tl_unit = params[:tl_unit] if params.key?(:tl_unit)
    @budget.pg_unit = params[:pg_unit] if params.key?(:pg_unit)
    @budget.designer_unit = params[:designer_unit] if params.key?(:designer_unit)
    @budget.category = params[:category] if params.key?(:category)
    @budget.contract_type = params[:contract_type] if params.key?(:contract_type)
    @budget.start_date = params[:start_date] if params.key?(:start_date)
    @budget.due_date = params[:due_date] if params.key?(:due_date)
    
    #estimation cost 
    @budget.pm_est = params[:pm_est] if params.key?(:pm_est)
    @budget.bsej_est = params[:bsej_est] if params.key?(:bsej_est)
    @budget.bsev_est = params[:bsev_est] if params.key?(:bsev_est)
    @budget.tl_est = params[:tl_est] if params.key?(:tl_est)
    @budget.pg_est = params[:pg_est] if params.key?(:pg_est)
    @budget.designer_est = params[:designer_est] if params.key?(:designer_est)
    @budget.commter_est = params[:commter_est] if params.key?(:commter_est)
    @budget.tester_est = params[:tester_est] if params.key?(:tester_est)
    @budget.other_est = params[:other_est] if params.key?(:other_est)
    @budget.calculate_total_est
    if @budget.save
      flash[:notice] = l(:notice_successful_update)
    else
      errors = @budget.errors.messages
      item = errors.keys.first
      error= errors[item]
      error_message = item.to_s + error.to_s;
      flash[:error] = l(:error_must_be_number)
      #flash[:error] = error_message
    end
    redirect_to :controller => 'projects',:action => "settings", :id => @project, :tab => 'budget' 
  end
    
end
