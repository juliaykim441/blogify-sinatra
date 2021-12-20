class RegistrationsController < ApplicationController
    get '/registrations/create_user' do 
        if !logged_in? 
            erb :'users/create_user', locals: {message: "Looks like you are not registerd with us. Please sign up before you sign in!"}
        else 
            redirect to '/blogs'
        end
    end

    post '/registrations/create_user' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/registrations/create_user'
        else
          @user = User.new(username: params[:username], email: params[:email], password: params[:password])
          @user.save
          session[:id] = @user.id
          redirect to '/blogs'
        end
    end

end