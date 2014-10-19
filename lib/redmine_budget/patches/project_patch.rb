require_dependency 'project'
module RedmineBudget
  module Patches

    module ProjectPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end
      
      module InstanceMethods
        def set_start_date
          cf = project.visible_custom_field_values
          return nil if cf.empty?
          custom_value = cf.select {|v| v.custom_field.name == l(:project_start_date_field)}.pop
          return custom_value.value if !custom_value.value.blank?
        end
        
        def set_due_date
          cf = project.visible_custom_field_values
          return nil if cf.empty?
          custom_value = cf.select {|v| v.custom_field.name == l(:project_due_date_field)}.pop
          return custom_value.value if !custom_value.value.blank?
        end
      end
    end
  
  end
end

unless Project.included_modules.include?(RedmineBudget::Patches::ProjectPatch)
  Project.send(:include, RedmineBudget::Patches::ProjectPatch)
end