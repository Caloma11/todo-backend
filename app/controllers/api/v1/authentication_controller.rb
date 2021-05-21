class Api::V1::AuthenticationController < Api::V1::BaseController

  skip_before_action :authenticate_user!, raise: false

  def create
    return unless params[:user]
    user = User.find_by(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password" ]}
    end
  end

end
