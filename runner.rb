require "graph"
require_relative "tweet_parser"


graph = Graph.new

tweet_data = TweetParser.new(ARGV[0])

tweet_data.users.each do |user| 
  Node.new(graph, user)
end

tweet_data.mentions.each do |author, recipients|
  from = graph.node(author)
  recipients.each do |recipient|
    to = graph.node(recipient)
    Edge.new(graph, from, to)
  end
end

graph.to_s