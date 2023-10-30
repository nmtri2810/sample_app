class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.name_max_length}
  validates :email, presence: true,
            length: {maximum: Settings.email_max_length},
            format: Settings.valid_email_regex, uniqueness: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true

  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost:
  end

  private

  def downcase_email
    email.downcase!
  end
end
