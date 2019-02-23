module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        current_user.present?
    end
    
    def security
        unless logged_in?
          redirect_to new_session_path
        end
    end
    
    def prohibited_access
        if current_user != @user
            redirect_to blogs_path
        end
    end
end
