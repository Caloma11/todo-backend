class Api::V1::NotesController < Api::V1::BaseController
  before_action :set_note, only: [:update, :destroy, :show]

  def index
    # authenticate_user!
    if current_user
      @notes = current_user.notes.order('updated_at DESC')
    else
      @notes = [Note.new(id: 999, title: "You aint logged in", description: "You aint logged in")]
    end
    # .map(&:attributes).map { |note| note.deep_transform_keys(&:to_sym) }
    # @notes.first[:active] = true
  end

  def show
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @note.update(note_params) && current_user == @note.user
      render :show
    else
      render_error
    end
  end

  def destroy
    @note.destroy
    render json: { message: "Successfully deleted"}
    # No need to create a `destroy.json.jbuilder` view
  end

  def bulk_destroy
    params[:notes].each do |note_id|
      Note.find(note_id)&.destroy
    end
    render json: { message: "Notes successfully deleted"}
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :description)
  end

  def render_error
    render json: { errors: @note.errors.full_messages },
      status: :unprocessable_entity
  end

  # def authenticate_token!
  #   payload = JsonWebToken.decode(auth_token)
  #   @current_user = User.find(payload["sub"])
  #   rescue JWT::ExpiredSignature
  #     render json: {errors: ["Auth token has expired"]}, status: :unauthorized
  #   rescue JWT::DecodeError
  #     render json: {errors: ["Invalid auth token"]}, status: :unauthorized
  # end

  # def auth_token
  #   @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
  #   # binding.pry
  # end
end
