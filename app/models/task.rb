class Task < ApplicationRecord
  belongs_to :list
  broadcasts_to :list

  validates :name, presence: true
end
