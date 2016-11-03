class Location < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->controller, model{controller && controller.current_user}

  ratyrate_rateable "service"
  
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy

  mount_uploader :picture, PictureUploader

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :name, length: {maximum: 150}, presence: true
  validates :category_id, presence: false
  validates :rating, presence: true,format: {with: /\A\d+(?:.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validate  :picture_size

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, t(:picturesize)
    end
  end
end
