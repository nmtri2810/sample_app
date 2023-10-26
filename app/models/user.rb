class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.name_max_length}
  validates :email, presence: true,
            length: {maximum: Settings.email_max_length},
            format: Settings.valid_email_regex, uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
