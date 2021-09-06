class PasswordController < ApplicationController
    before_action :required_user_login!
    def edit
    
    end

    def update
        user = User.find_by(id: Current.user.id)
        if(user.update(params_update))
            redirect_to root_path, success: "Password updated successfully!"
        else
            flash[:info] = "Incorrect password!"
            render :edit
        end
    end

    def params_update
        params.require(:user).permit(:password, :password_confirmation)
    end
end