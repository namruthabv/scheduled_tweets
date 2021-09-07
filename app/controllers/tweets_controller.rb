class TweetsController < ApplicationController
    before_action :required_user_login!
    before_action :set_tweet, only: [:edit, :destroy, :update, :show]

    def index
        @tweets = Current.user.tweet
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweet.new(tweet_params)
        if @tweet.save
            flash[:success] = "Tweet is scheduled successfully!"
            redirect_to tweets_path
        else 
            @tweet.errors.full_messages.each do |msg|
                flash[:danger] ||= []
                flash[:danger] << msg 
            end
            render :new
        end
    end

    def edit

    end

    def update
        if @tweet && @tweet.update(tweet_params)
            flash[:success] = "Successfully updated the tweet!"
            redirect_to tweets_path
        else
            @tweet.errors.full_messages.each do |msg|
                flash[:danger] ||= []
                flash[:danger] << msg 
            end
            render :edit
        end  
    end

    def destroy
        @tweet.destroy
        flash[:success] = "Successfully deleted the tweet!"
        redirect_to tweets_path
    end

    private
    def tweet_params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end

    def set_tweet
        @tweet = Current.user.tweet.find_by(id: params[:id])
    end
end