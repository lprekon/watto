class FieldUserValue < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :field
  belongs_to :field_allowed_value, optional: true

  delegate :category, to: :field_allowed_value
  delegate :name, to: :field_allowed_value
  delegate :novapass?, to: :field_allowed_value
  delegate :label, to: :field_allowed_value, allow_nil: true
  delegate :position, to: :field_allowed_value

  scope :signoffs, -> {
    includes(:field_allowed_value)
      .where(field: Field.signoffs)
      .order("field_allowed_values.position ASC")
  }
end
