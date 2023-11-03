class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [Settings.image_size,
                                                   Settings.image_size]
  end

  validates :content, presence: true,
             length: {maximum: Settings.content_max_length}
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png),
                                   message: I18n.t("image_format")},
                    size: {less_than: Settings.image_mb.megabytes,
                           message: I18n.t("image_size")}

  scope :recent_posts, ->{order(created_at: :desc)}
end
