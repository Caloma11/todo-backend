class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  def secret_key
    'lulamolusco'
  end

  def encode(payload)
    JWT.encode(payload, secret_key, 'HS256')
  end

  def decode(token)
     JWT.decode(token, "anything", 'lulamolusco', {algorithm: 'HS256'})[0]
  end

end
