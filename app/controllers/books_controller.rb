class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user_books, only: [:edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book=Book.new
    @book_detail=Book.find(params[:id])

  end

  def edit
    @book=Book.find(params[:id])
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id

    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      render :index
    end

  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end

  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def ensure_correct_user_books
      book = Book.find(params[:id])
      unless current_user.id == book.user_id
        redirect_to books_path
      end
    end


end
