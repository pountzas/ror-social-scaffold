class Api::CommentsController < ApiController
  # def index
  #   @comments = Post.comments
  #   render json: @comments
  # end

  # def show
  #   @comment = Post.find(params[:post_id]).comments
  #   render json: @comment
  # end

  def show
    @comment = Post.find(params[:id]).comments
    render json: { comments: @comment }
  end
end
