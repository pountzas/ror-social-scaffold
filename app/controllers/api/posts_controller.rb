class Api::PostsController < ApiController
  def index
    @posts = Post.all
    render json: { posts: @posts }
  end

  def show
    @post = Post.find(params[:id]).comments
    render json: { comments: @post }
  end
end
