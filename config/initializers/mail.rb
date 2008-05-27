ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => "smtp.126.com",
    :domain => "nnnnon.heroku.com",
    :authentication => :login,
    :user_name => "malijun4363@126.com",
    :password => "19160881"
}