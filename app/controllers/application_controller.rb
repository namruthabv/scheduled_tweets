class ApplicationController < ActionController::Base
    add_flash_types :info, :error, :warning, :success, :danger
    before_action :set_current_user

    private
    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def required_user_login!
        if Current.user.nil?
            flash[:danger] = "User must login!"
            redirect_to login_path
        end
    end
end
