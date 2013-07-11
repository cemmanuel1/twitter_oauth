get '/' do

  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do

  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  @user = User.find_by_username(@access_token.params[:screen_name])
  unless @user
   @user = User.create(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
 end
 session[:user_id] = @user.id

 redirect "/#{@user.username}"

end

get "/:username" do
  @user = User.find_by_username(params[:username])
  erb :create_tweet
end

get "/:username/tweets" do 

  @me = User.find_by_username(params[:username])
  # tweet = Tweet.create(tweet: params[:tweet], user_id: @me.id)
   @me.tweet_stuff(params[:tweet])

   @me
 erb :yay
end
