class AddDueDateAndReminderToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :due_date, :datetime
    add_column :tasks, :reminder, :datetime
  end
end
