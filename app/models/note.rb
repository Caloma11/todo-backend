class Note < ApplicationRecord
  belongs_to :user, optional: true
  # attribute :active, default: false

end
