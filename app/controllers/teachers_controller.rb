class TeachersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/teachers/signup'
        else
            redirect '/students'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'/teachers/login'
        else
            redirect '/students' 
        end
    end

end