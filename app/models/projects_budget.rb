class ProjectsBudget < ActiveRecord::Base
  unloadable
  
  CATEGORY_INTERNAL = 0
  CATEGORY_EXTERNAL = 1
  CONTRACT_TYPE_NONE = 0
  CONTRACT_TYPE_PROJECT = 1
  CONTRACT_TYPE_LABO = 2
  
  DEFAULT_CONFIG = {
    'pm_unit'       => '40',
    'bsej_unit'     => '60',
    'bsev_unit'     => '40',
    'tl_unit'       => '27',
    'pg_unit'       => '22',
    'designer_unit' => '22',
    'commter_unit'  => '0',
    'tester_unit'   => '0',
    'category'      => '1',
    'contract_type' => '1'
  }

  belongs_to :project
  validates_uniqueness_of :project_id
  validates :project_id, :presence => true
  validates :start_date, :date => true
  validates :due_date, :date => true
  validates :pm_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :bsej_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :bsev_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :tl_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :pg_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :designer_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :commter_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :tester_unit, numericality: {:only_integer => true,:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  validates :pm_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :bsej_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :bsev_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :tl_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :pg_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :designer_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :commter_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :tester_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid}
  validates :other_est, numericality: {:greater_than_or_equal_to => 0, :allow_nil => true, :message => :invalid }
  
  
  def self.budget_config(project)
    project_id = project.is_a?(Project) ? project.id : project

    bud_config = self.find_by_project_id(project_id)
    project_period = self.get_project_period(project)
    unless bud_config
      bud_config = ProjectsBudget.new
      bud_config.project_id = project_id
      #default value
      bud_config.pm_unit = DEFAULT_CONFIG['pm_unit']
      bud_config.bsej_unit = DEFAULT_CONFIG['bsej_unit']
      bud_config.bsev_unit = DEFAULT_CONFIG['bsev_unit']
      bud_config.tl_unit = DEFAULT_CONFIG['tl_unit']
      bud_config.pg_unit = DEFAULT_CONFIG['pg_unit']
      bud_config.designer_unit = DEFAULT_CONFIG['designer_unit']
      bud_config.commter_unit = DEFAULT_CONFIG['commter_unit']
      bud_config.tester_unit = DEFAULT_CONFIG['tester_unit']
      bud_config.category = DEFAULT_CONFIG['category']
      bud_config.contract_type = DEFAULT_CONFIG['contract_type']
      bud_config.start_date = project_period['start_date'] if !project_period['start_date'].blank?
      bud_config.due_date = project_period['due_date'] if !project_period['due_date'].blank?
      bud_config.save
    end
    bud_config
  end
  
  #get default start date and due date from project custom fields
  def self.get_project_period(project)
    res = {
      'start_date' => nil,
      'due_date' => nil
    }  
    values = project.visible_custom_field_values
    return res if values.empty?
    project.visible_custom_field_values.each do |custom_value|
      if custom_value.custom_field.name == l(:project_start_date_field)
        res['start_date'] = custom_value.value if !custom_value.value.blank?
      end
      if custom_value.custom_field.name == l(:project_due_date_field)
        res['due_date'] = custom_value.value if !custom_value.value.blank?
      end
    end
    
    return res
  end
  
  #return string that recusive by labo contract
  def monthly
    res = ""
    if self.contract_type == CONTRACT_TYPE_LABO
      res = l(:label_budget_monthly) << " | "
    end
    res
  end
  
  #calculate total 
  def calculate_total_est
    pm_cost = self.has_attribute?(:pm_unit) && self.has_attribute?(:pm_est) ? self.pm_unit * self.pm_est : 0
    bsej_cost = self.has_attribute?(:bsej_unit) && self.has_attribute?(:bsej_est) ? self.bsej_unit * self.bsej_est : 0
    bsev_cost = self.has_attribute?(:bsev_unit) && self.has_attribute?(:bsev_est) ? self.bsev_unit * self.bsev_est : 0
    tl_cost = self.has_attribute?(:tl_unit) && self.has_attribute?(:tl_est) ? self.tl_unit * self.tl_est : 0
    pg_cost = self.has_attribute?(:pg_unit) && self.has_attribute?(:pg_est) ? self.pg_unit * self.pg_est : 0
    designer_cost = self.has_attribute?(:designer_unit) && self.has_attribute?(:designer_est) ? self.designer_unit * self.designer_est : 0
    commter_cost = self.has_attribute?(:commter_unit) && self.has_attribute?(:commter_est) ? self.commter_unit * self.commter_est : 0
    tester_cost = self.has_attribute?(:tester_unit) && self.has_attribute?(:tester_est) ? self.tester_unit * self.tester_est : 0
    
    total_cost = pm_cost + bsej_cost + bsev_cost + tl_cost + pg_cost + designer_cost + commter_cost + tester_cost
    self.total_est = total_cost
  end
end
