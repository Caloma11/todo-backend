class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:user][:email])
    # check if valid password with devise
    if user.valid_password?(params[:user][:password])
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password" ]}
    end
  end

end
