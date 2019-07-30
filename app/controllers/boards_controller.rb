class BoardsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @boards = Board.all
    end

    def show
        # @board = Board.find(params[:id]) ←普通の記述
        @board = Board.includes(:comments).find(params[:id])
        # ↑ 親モデルをとってくるついでに子モデルも取ってこれる。それがincludes。
        @comment = Comment.new
    end 

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(params_board)
        # @board.save
        # redirect_to "/boards"
        # ↑ resoucesを使わない書き方
        # redirect_to board_url(@board)
        if @board.save
            redirect_to board_url(@board)
            # ↑ 保存できた時のリダイレクト先
        else
            render "new"
            # ↑ 保存出来なったときの遷移先 ※renderは情報を保持したまま遷移する
        end
    end

    def edit
        @board = Board.find(params[:id])
    end

    def update
        @board = Board.find(params[:id])
        # @board.update_attributes(params_board)
        # redirect_to "/boards/#{@board.id}"
        # ↑ resourcesを使わない書き方
        # redirect_to board_url(@board)
        if @board.update_attributes(params_board)
            redirect_to board_url(@board)
        else
            render "edit"
        end
        # ↑条件分岐の書き方
    end

    def destroy
        @board = Board.find(params[:id])
        @board.destroy
        # redirect_to "/boards"
        # ↑ resourcesを使わない書き方
        redirect_to boards_url
    end

    private

    # def params_board
        # params.permit(:title, :editor)
    # end
    # ↑ form_forタグに対応させる為に↓に変更する
    def params_board
        params.require(:board).permit(:title, :editor)
    end
end
