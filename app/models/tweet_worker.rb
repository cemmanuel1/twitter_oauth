# app/models/tweet_worker.rb
class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    puts "I am in perform"
    your_tweet = Tweet.find(tweet_id)
    user_id = your_tweet.user_id
    me = User.find(user_id)
    puts me
    you = Twitter::Client.new(
      :oauth_token => me.oauth_token,
      :oauth_token_secret => me.oauth_secret
      )
   p you
    you.update(your_tweet.tweet)
    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end
end
