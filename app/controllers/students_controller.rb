class StudentsController < ApplicationController

    get '/students' do
        if logged_in?
            @students = Student.all
            erb :'/students/index'
        else
            redirect '/login'
        end
    end

    get '/students/new' do
        if logged_in?
            erb :'/students/new'
        else
            redirect '/login'
        end
    end

    post '/students' do
        if logged_in?
             if params[:first_name]!= "" && params[:last_name] != ""
                 @student=Student.new(params)
                 @student.teacher=current_user
                 @student.save
                 redirect "/students/#{@student.id}" 
             else
                 redirect '/students/new'
             end
         else
             redirect '/login'
         end
     end

    get '/students/:id' do
        if logged_in?
            @student=Student.find_by_id(params[:id])
            erb :'/students/show'
        else
            redirect '/login'
        end
    end

    get '/students/:id/edit' do
        if logged_in?
            @student=Student.find_by_id(params[:id])
            if @student && @student.teacher==current_user
                erb :'/students/edit'
            else
                redirect '/sorry'
            end
        else
            redirect '/login'
        end
    end

    patch '/students/:id' do
        if logged_in?
            if params[:first_name] != "" && params[:last_name] != ""
                @student=Student.find_by_id(params[:id])
                @student.update(first_name: params[:first_name],last_name: params[:last_name],age: params[:age],gender: params[:gender],grade: params[:grade],subject: params[:subject])
                redirect "/students/#{@student.id}" 
            else
                redirect "/students/#{params[:id]}/edit" 
            end
        else
            redirect '/login'
        end
    end

    get '/sorry' do
        erb :'/students/sorry'
    end

    get '/students/myclass' do
        if logged_in?
            @this_class=[]
            Student.all.each do |student|
                if student.teacher==current_user
                    @this_class << student
                end
            end
            erb :'/students/by_class'
        else
            redirect '/login'
        end      
    end

    delete '/students/:id/delete' do
        if logged_in?
            @student = Student.find_by_id(params[:id])
            if @student && @student.teacher==current_user
                @student.delete
            end
            redirect '/sorry'
        else
            redirect 'login'
        end
    end

end