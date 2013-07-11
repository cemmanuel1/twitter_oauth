class User < ActiveRecord::Base
  # Remember to create a migration!
    has_many :tweets

    def tweet_stuff(status)
      puts "I am in here"
      tweet = self.tweets.create!(:tweet => status)
puts tweet.id
      TweetWorker.perform_async(tweet.id)
  end
end
