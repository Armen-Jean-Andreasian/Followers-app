class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # Shows all comments on a particular post
  def show
  end


  # Edit a comment
  def edit
  end

  # Create a new comment
  def create
    @comment = Comment.new(comment_params)
  end

  # Updates a comment
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Deletes a comment
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_path, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :commenter_id, :commented_to_id, :commented_to_type, :created_at ])
    end
end
