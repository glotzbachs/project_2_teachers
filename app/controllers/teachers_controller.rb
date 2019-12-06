class TeachersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/teachers/signup'
        else
            redirect '/students'
        end
    end

    post '/signup' do
        if valid_signup? && !not_valid_username && !not_valid_email
            @teacher=Teacher.new(params) 
            @teacher.save
            session[:teacher_id]=@teacher.id
            redirect '/students'   
        else  
            redirect '/sorry_signup'
        end
    end

    get '/sorry_signup' do
        erb :'/teachers/sorry_signup'
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
			redirect "/sorry_login"
        end
    end

    get '/sorry_login' do
        erb :'/teachers/sorry_login'
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
        redirect "/"
    end

end