class UserMailer < ApplicationMailer

  def delete_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Deleted")
  end

end
