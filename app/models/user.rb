class User < ActiveRecord::Base

  has_many :reviews

  validates :email, :firstname, :lastname, presence: true
  has_secure_password

  def full_name
    "#{firstname} #{lastname}"
  end

end
