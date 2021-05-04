class UsersController < ApplicationController

  def login
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      token = encode(payload)
      render json: { user: user, token: token }
    else
      render json: { error: "Unable to login" }
    end
  end

  def token_authenticate
    token = request.headers["Authenticate"]
    user = User.find(decode(token)["user_id"])
    render json: user
  end

end
