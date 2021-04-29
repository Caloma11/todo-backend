class Api::V1::NotesController < Api::V1::BaseController
  before_action :set_note, only: [:update, :destroy, :show]

  def index
    @notes = Note.order('updated_at DESC')
    # .map(&:attributes).map { |note| note.deep_transform_keys(&:to_sym) }
    # @notes.first[:active] = true
  end

  def show
  end

  def create
    @note = Note.new(note_params)
    # @note.user = current_user
    if @note.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @note.update(note_params)
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
end
