class CreateProjectsBudgets < ActiveRecord::Migration
  def change
    create_table :projects_budgets do |t|
      t.integer :project_id,:default => 0,:null => false
      t.date :start_date
      t.date :due_date
      t.integer :category,:default => 0
      t.integer :contract_type,:default => 0
      t.integer :pm_unit,:default => 40
      t.integer :bsej_unit,:default => 60
      t.integer :bsev_unit,:default => 40
      t.integer :tl_unit,:default => 27
      t.integer :pg_unit,:default => 22
      t.integer :designer_unit,:default => 22
      t.integer :commter_unit,:default => 0
      t.integer :tester_unit,:default => 0
      t.decimal :pm_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :bsej_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :bsev_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :tl_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :pg_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :designer_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :commter_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :tester_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :other_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :total_est,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :pm_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :brsej_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :brsev_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :tl_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :pg_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :designer_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :commter_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :tester_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :other_real,:precision=>6,:scale=>2, :default => "0.0"
      t.decimal :total_real,:precision=>6,:scale=>2, :default => "0.0"
    end

  end
end
