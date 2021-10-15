class Api::PostsController < ApiController
  def index
    @posts = Post.all
    render json: { posts: @posts }
  end

  # def show
  #   @post = Post.find(params[:id])
  #   render json: @post
  # end
end
