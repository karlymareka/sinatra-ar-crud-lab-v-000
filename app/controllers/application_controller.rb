
require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    redirect '/articles/new'
  end
  
  get '/articles/new' do  
    erb :new 
  end
  
  post '/articles' do
    @article = Article.create(params[:article])
    redirect "/articles/#{@article.id}"
  end
  
  get '/articles' do 
    @articles = Article.all
    erb :index 
  end 
  
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show 
  end
  
  get '/articles/:id/edit' do
    @article = Article.find_by(params[:id])
    erb :edit
  end 
  
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    binding.pry 
    @article.update(title: params[:title], content: params[:content])
    @article.save
    #redirect "/articles/#{@article.id}"
    erb :edit 
    
  end
  
  
end
