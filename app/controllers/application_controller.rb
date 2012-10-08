class ApplicationController < ActionController::Base
  #protect_from_forgery

private

  def current_user
    if session_number = session[:session_number]
      s = Session.find(session_number) rescue nil
    end

    unless s
      s = Session.find_or_create_by_ip(request.remote_ip)
      session[:session_number] = s.id
    end

    s    
  end
  
end
