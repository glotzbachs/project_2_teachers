require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secure_teacher"
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def current_user
      @current_user ||= Teacher.find_by_id(session[:teacher_id]) if !! session[:teacher_id]
    end
    
    def logged_in?
      !!current_user
    end

  end

end
