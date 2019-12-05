class TeachersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/teachers/signup'
        else
            redirect '/students'
        end
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @teacher=Teacher.new(params)
            @teacher.save
            session[:teacher_id]=@teacher.id
            redirect '/students'   
        else  
            redirect '/signup'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'/teachers/login'
        else
            redirect '/students' 
        end
    end

    post '/login' do
        @teacher = Teacher.find_by(username: params[:username])
	    if @teacher && @teacher.authenticate(params[:password])
			session[:teacher_id] = @teacher.id
			redirect "/students"
		else
			redirect "/login"
        end
    end

    get '/logout' do
        if logged_in?
            erb :'teachers/logout'
        else
            redirect to "/"
        end 
    end

    post '/logout' do
        session.destroy
        redirect "/login"
    end

end