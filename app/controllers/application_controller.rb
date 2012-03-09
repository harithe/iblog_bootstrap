class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :articles_tags

  unless config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    # customize these as much as you want, ie, different for every error or all the same
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  private

  def render_not_found(exception)
    #render :template => "/errors/404.html.erb", :status => 404
    redirect_to root_path
  end

  def render_error(exception)
    # you can insert logic in here too to log errors
    # or get more error info and use different templates
    #render :template => "/errors/500.html.erb", :status => 500
    redirect_to root_path
  end

  def articles_tags
    @tags = Article.tag_counts_on(:tags)
  end
end
