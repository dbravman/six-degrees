require "rgl/adjacency"
require_relative "tweet_parser"

graph = RGL::AdjacencyGraph.new

tweet_data = TweetParser.new(ARGV[0])

tweet_data.users.each do |user| 
  graph.add_vertex(user)
end

tweet_data.mentions.each do |author, recipients|
  from = author
  recipients.each do |recipient|
    to = recipient
    graph.add_edge(from, to)
  end
end

p graph.to_s