class Review < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create,
    owner: ->controller, model{controller && controller.current_user},
    recipient: ->controller, model{model && model.user}

  acts_as_votable
  
  belongs_to :location
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy

  validates :location_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 255}
end
