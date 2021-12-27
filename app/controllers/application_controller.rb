require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'

  end

  get "/" do
    erb :welcome
  end

  get '/registrations/create_user' do 
    if !logged_in? 
        erb :'registrations/create_user', locals: {message: "Looks like you are not registerd with us. Please sign up before you sign in!"}
    else 
        redirect to '/blogs'
    end
  end 

  post '/create_user' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/registrations/create_user'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/blogs'
    end
  end

  get '/sessions/login' do 
    if !logged_in? 
        erb :'sessions/login'
    else 
        redirect to '/blogs'
    end 
  end 

  post '/login' do 
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to '/blogs'
    else 
      redirect to '/registrations/create_user'
    end 
  end

  get '/logout' do 
    # if logged_in?
    #     session.destroy
    #     redirect to '/login'
    # else 
    session.clear
    redirect to '/'
  end

  get '/users/show' do
    @user = User.find(session[:user_id])
    erb :'/users/show'
  end

  helpers do 
    def logged_in? 
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end
end

