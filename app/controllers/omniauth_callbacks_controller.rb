class OmniauthCallbacksController < ApplicationController
    before_action :required_user_login!
    
    def twitter
        # render plain: "Success!"
        Rails.logger.info auth
        twitter = Current.user.twitter_account.where(username: auth.info.nickname).first_or_initialize
        twitter.update(
            name: auth.info.name,
            username: auth.info.nickname,
            image: auth.info.image,
            secret: auth.credentials.secret,
            token: auth.credentials.token
        )

        flash[:info] = "Successfully connected your account!"
        redirect_to twitter_accounts_path
    end

    def auth
        request.env["omniauth.auth"]
    end
end