IBlogBootstrap::Application.routes.draw do
  devise_for :users

	namespace :admin do
	  match '/', :to => "base#index"
    resources :articles
	end

  resources :articles, :only => [:index, :show] do
    resources :comments, :only => :create, :controller => 'articles/comments'
  end

  root :to => 'articles#index'
end
