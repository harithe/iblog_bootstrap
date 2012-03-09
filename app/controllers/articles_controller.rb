class ArticlesController < ApplicationController

  # GET /articles
  # GET /articles.json
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).page(params[:page])
    else
      @articles = Article.published.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.includes(:comments).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end
end