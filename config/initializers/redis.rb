require 'redis'

uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379")
REDIS = Redis.new(:url => ENV['REDISTOGO_URL'])