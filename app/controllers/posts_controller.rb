class PostsController < ApplicationController
  # createアクションの前に処理を一度止めてトークンを確認してみる
  # before_actionチェーンの先頭で実行する
  prepend_before_action :confirm_authenticity_token, only: :create
  before_action :set_post, only: %i[ show edit update destroy ]
  
  # protect_from_forgeryのデフォルト設定（CSRF対策に引っかかった場合、例外を発生させる）
  # protect_from_forgery with: :exception 
  
  # createアクションでprotect_from_forgeryを無効にする
  protect_from_forgery except: :create
  
  ## 参考 ##############################################################################################################################
  ## https://railsguides.jp/initialization.html#railties-lib-rails-all-rb                                                             ##
  ## https://github.com/rails/rails/commit/ec4a836919c021c0a5cf9ebeebb4db5e02104a55                                                   ##
  ## https://github.com/rails/rails/blob/ec4a836919c021c0a5cf9ebeebb4db5e02104a55/actionpack/lib/action_controller/railtie.rb#L73-L78 ##
  #####################################################################################################################################
  
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    # Confirm authenticity_token
    def confirm_authenticity_token
      binding.pry
    end
end
