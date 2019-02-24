class BlogsController < ApplicationController
  before_action :set_blog, only:[:show, :edit, :update, :destroy]
  before_action :security, only:[:show, :edit, :new, :destroy]
  before_action :prohibited_access_to_blogs, only:[:edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
      @blog=Blog.new(blog_params)
    else
      @blog=Blog.new
    end
  end
  
  def create
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      CreateMailer.create_blog_mail(@blog).deliver
      redirect_to blogs_path,notice:"ブログを作成しました！"
    else
      render 'new'
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    binding.pry
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end
  
private

  def blog_params
    params.require(:blog).permit(:content, :image, :image_cache)
  end
  
  def set_blog
    @blog=Blog.find(params[:id])
  end
end
