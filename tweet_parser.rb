class TweetParser
  attr_reader :mentions, :users

  def initialize(file)
    tweets = IO.readlines(file)
    @mentions = {}
    tweets.each do |tweet| 
      user = parse_user(tweet)
      if @mentions[user] == nil
        @mentions[user] = parse_mentions(tweet)  
      else 
        @mentions[user] += parse_mentions(tweet)
      end
      @users = find_names
    end
    
  end

  def parse_user(tweet)
    tweet[/^\w+:/][0...-1]
  end

  def parse_mentions(tweet)
    tweet.scan(/@\w+\b/).map {|name| name[1..-1]}
  end

  def find_names
    users = []
    @mentions.keys.each {|name| users << name}
    @mentions.values.flatten.each {|name| users << name}
    users.uniq
  end
end