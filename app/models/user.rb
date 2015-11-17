class User < ActiveRecord::Base

  has_many :reviews

  validates :email, :firstname, :lastname, presence: true
  has_secure_password
end
