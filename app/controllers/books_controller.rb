class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def show

  end

  def edit
  end
end
