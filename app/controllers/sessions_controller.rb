class SessionsController < ApplicationController
  

    get '/sessions/login' do
        if !logged_in? 
            erb :'sessions/login'
        else 
            redirect to '/blogs'
        end 
    end
  
    post '/sessions' do
      @user = User.find_by(email: params["email"], password: params["password"])
      session[:id] = @user.id
      redirect '/users/show'
    end

    get '/sessions/logout' do 
        # log out the user by clearing the session hash here
        session.clear
        redirect '/'
    end
  
    # get '/sessions/logout' do 
    #     if logged_in?
    #         session.destroy
    #         redirect to '/login'
    #     else 
    #         redirect to '/'
    #     end
    # end

  end