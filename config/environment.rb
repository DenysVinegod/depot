# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Mail
Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'denys.vinegod',
    authentication: 'plain',
    user_name: 'depot@example.com',
    password: '#F@nta$228',
    enable_starttls_auto: true
  }
end
