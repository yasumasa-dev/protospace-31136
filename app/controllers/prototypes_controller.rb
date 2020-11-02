class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show]


  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save #入力フォームデータベースにprototypeを保存
      redirect_to root_path #保存できればルートパスに移動
    else
      render :new #入力フォームの値が空であれば新規投稿画面に移動
    end
  end

  def show #showアクションにインスタンス変数@prototype定義
    @prototype = Prototype.includes(:user).find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
    #@prototype = Prototype.find(params[:id])#pathパラメータで送信されるID値で特定のオブジェクトを取得し@prototypeに代入
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params #createアクションのストロングパラメーターの設定
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end