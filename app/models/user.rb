class User < ActiveRecord::Base
  validates :email, :firstname, :lastname, presence: true
  has_secure_password
end
