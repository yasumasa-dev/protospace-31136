class PrototypesController < ApplicationController
  def index
    @prototype = Prototype.all
  end

  def destroy
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
    @prototype = Prototype.find(params[:id])#pathパラメータで送信されるID値で特定のオブジェクトを取得し@prototypeに代入
  end


  private

  def prototype_params #createアクションのバリデーション設定だっけ？
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end
end