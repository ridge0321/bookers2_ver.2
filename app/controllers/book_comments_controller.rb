class BookCommentsController < ApplicationController
  before_action :ensure_correct_comment_user, only: :destroy

  def create
    book_comment = BookComment.new(book_comment_params)

    book = Book.find(params[:book_id])
    book_comment.book_id = book.id
    book_comment.user_id = current_user.id
    book_comment.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    book_comment.destroy
    redirect_to book_path(book_comment.book_id)
  end




  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def ensure_correct_comment_user
    book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])

    unless book_comment.user_id == current_user.id
      redirect_to book_path(book_comment.book_id)
    end

  end
end