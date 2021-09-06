class TwitterAccountsController < ApplicationController
    before_action :required_user_login!
    before_action :set_twitter_account, only: [:destroy]

    def index
        @twitter_accounts = Current.user.twitter_account
    end

    def destroy
        @current_twitter_acc.destroy 
        flash[:success] = "Successfully disconnected with @#{@current_twitter_acc.username} twitter account"
        redirect_to twitter_accounts_path
    end

    private
    def set_twitter_account
        @current_twitter_acc = Current.user.twitter_account.find_by(id: params[:id])
    end
end