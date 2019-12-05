class StudentsController < ApplicationController

    get '/students' do
        if logged_in?
            @students = Student.all
            erb :'/students/index'
        else
            redirect '/login'
        end
    end

end