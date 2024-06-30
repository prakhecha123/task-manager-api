class Task < ApplicationRecord
    validates :title, presence: true
    validates :status, inclusion: { in: %w[To\ Do In\ Progress Done], message: "%{value} is not a valid status" }
    validate :reminder_before_due_date
  
    private
  
    def reminder_before_due_date
      if reminder.present? && due_date.present? && reminder >= due_date
        errors.add(:reminder, "must be before the due date")
      end
    end
end
  