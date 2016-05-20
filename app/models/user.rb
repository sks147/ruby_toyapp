class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates(:name, presence: true, length: { maximum: 50 })
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false} )
  has_secure_password
  validates(:password, length:{ minimum: 6 })

end
# has_secure_password adds following functions
# ability to save a securely hashed password_digest attribute to the database
# virtual attributes (password and password_confirmation)
# an authenticate method that returns the user when the password is correct and false otherwise
# 