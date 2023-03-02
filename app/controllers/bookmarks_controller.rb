class BookmarksController < ApplicationController
  before_action :set_list, only: %i[create new]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(safe_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = List.find(@bookmark.list_id)
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private

  def safe_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
