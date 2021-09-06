class User < ApplicationRecord
    has_secure_password
    has_many :twitter_account
    has_many :tweet
    
    validates :email, :password, presence: true
    validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email!"}
end
