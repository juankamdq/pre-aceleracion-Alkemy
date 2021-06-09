class ApplicationMailer < ActionMailer::Base
  default from: "apidisney@gmail.com"

  def welcome_email(user)
    @user = user
  
    mail to:  @user.email, subject: "Welcome to Disney Appi"
  end
end
