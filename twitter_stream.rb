# Given:

# 1.) 2 models TwitterHandle and Tweet

# [TwitterHandle]
# * id :int
# * url :string
# * created_at :datetime
# * modified_at :datetime

# [Tweet]
# * id :int
# * twitter_handle_id :int
# * tweet :text
# * created_at :datetime
# * modified_at :datetime

# 2.) The class below
 
# Requirement:

# The application stores tweets from Twitter.  There are too many Twitter handles
# to store all of the Tweets.  The application should import a sample of the users
# tweets.  The first time the handle is added the next 30 days of Tweets should be 
#imported, then following that every 6 months 30 days of Tweets should be imported. 
# Please add code to the given example to implement this.


class TweetImporter

def create_stream(handles)
  handles_for_stream = {}
  handles.each do |x|
    handles_for_stream << x.url
  end
  TwitterStream.subscribe_to_handles(handles_for_stream)
end

def import_tweets
  handles = get_handles_to_import
  stream = create_stream(handles)
  stream.each do |tweet|
    twitter_handle = TwitterHandle.find_by_url(tweet.handle)
    new_tweet = twitter_handle.tweet.build
    new_tweet.tweet = tweet.body
    new_tweet.save
  end
end

def get_handles_to_import
  #
  # put your code here
  #
  TwitterHandle.all.first
end
