class User < ApplicationRecord

  has_many :plants

  validates_presence_of :username
  validates :username, length: (6..15), uniqueness: true

  validates :password, length: (6..20), allow_nil: true

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def is_password?(password_attempt)
    BCrypt::Password.new(password_digest).is_password?(password_attempt)
  end

  def password=(raw_password)
    @password = raw_password
    self.password_digest = BCrypt::Password.create(raw_password)
  end

end
