class StudentsController < ApplicationController

    get '/students' do
        if logged_in?
            @students = Student.all.order(:last_name)
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

     get '/students/myindex' do
        if logged_in?
            @students=current_user.students.order(:last_name)
            erb :'/students/myindex'
        else
            redirect '/login'
        end      
    end

    get '/students/:id' do
        if logged_in?
            @student=Student.find_by_id(params[:id])
            if current_user.students.include?(@student)
                @my_student=@student
            end
            erb :'/students/show'
        else
            redirect '/login'
        end
    end

    get '/students/:id/edit' do
        if logged_in?
            @student=current_user.students.find_by_id(params[:id])
            if @student
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

    delete '/students/:id/delete' do
        if logged_in?
            @student = current_user.students.find_by_id(params[:id])
            if @student
                @student.delete
                redirect '/students'
            else
                redirect '/sorry'
            end
        else
            redirect 'login'
        end
    end

end