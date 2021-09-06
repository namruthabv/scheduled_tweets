class PasswordResetController < ApplicationController
    def new

    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            PasswordMailer.with(user: @user).reset.deliver_later
        end
        
        redirect_to root_path, info: "If the user was found, email have been sent to your inbox!"
    end

    def edit 
        begin
            @user = User.find_signed!(params[:token], purpose: "reset_password")
        rescue ActiveSupport::MessageVerifier::InvalidSignature
            flash[:danger] = "Token expired! Please try again."
            redirect_to login_path
        end
    end

    def update 
        @user = User.find_signed!(params[:token], purpose: "reset_password")
        if @user.present? && @user.update(user_params)
            flash[:success] = "Password was reset successfully!"
            redirect_to login_path
        else
            @user.errors.full_messages.each do |msg|
                flash[:danger] ||= []
                flash[:danger] << msg
            end 
            render :edit
        end
    end

    private
    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end