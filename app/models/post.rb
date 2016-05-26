class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :title,    presence: true
  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 140 }
  validates :price,    presence: true
  validate  :picture_size
  
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "should be less than 3MB")
      end
    end
end