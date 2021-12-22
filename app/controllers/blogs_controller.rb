class BlogsController < ApplicationController
    get '/blogs' do 
        if logged_in? 
            @blogs = current_user.blogs
            erb :'blogs/blogs'
        else
            redirect to '/sessions/login'
        end
    end

    get '/blogs/new' do 
        if logged_in? 
            erb :'blogs/create_blog'
        else
            redirect to '/sessions/login'
        end 
    end

    post '/blogs' do 
        if logged_in? 
            if params[:content] == ""
                redirect to "/blogs/new"
            else 
                @blog = current_user.blogs.build(content: params[:content], title: params[:title])
                if @blog.save
                    redirect to "/blogs/#{@blog.id}"
                else
                    redirect to "/blogs/new"
                end 
            end 
        else 
            redirect to '/sessions/login'
        end 
    end

    get '/blogs/:id' do
        if logged_in?
          @blog = current_user.blogs.find_by_id(params[:id])
          erb :'blogs/show_blog'
        else
          redirect to '/sessions/login'
        end
      end
    
      get '/blogs/:id/edit' do
        if logged_in?
          @blog = Blog.find_by_id(params[:id])
          if @blog && @blog.user == current_user
            erb :'blogs/edit_blog'
          else
            redirect to '/blogs'
          end
        else
          redirect to '/sessions/login'
        end
      end
    

    patch '/blogs/:id' do 
        if logged_in? 
            if params[:content] == ""
                redirect to "/blogs/#{params[:id]}/edit"
            else 
                @blog = current_user.blogs.find_by(params[:id])
                if @blog && @blog.user == current_user
                    if @blog.update(content: params[:content], title: params[:title])
                        redirect to "/blogs/#{@blog.id}"
                    else 
                        redirect to "/blogs/#{@blog.id}/edit"
                    end 
                else 
                    redirect to '/blogs'
                end 
            end
        else 
            redirect to '/sessions/login'
        end 
    end

    delete '/blogs/:id/delete' do 
        if logged_in? 
            @blog = Blog.find_by_id(params[:id])
            if @blog && @blog.user == current_user
                @blog.delete
            end 
            redirect to '/blogs'
        else 
            redirect to '/sessions/login'
        end 
    end

end