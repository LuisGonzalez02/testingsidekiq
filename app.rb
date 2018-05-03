require 'sinatra/base'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'




class App < Sinatra::Base
	class TestWorker
	include Sidekiq::Worker
		def perform(sleep_time)
			sleep sleep_time
			account_sid = 'AC3040bfd66e0c15eeae03e6b7bd55443c'
			auth_token = 'a10018bf4cfb66aa234e84b45960c3f5'

			# set up a client to talk to the Twilio REST API
			@client = Twilio::REST::Client.new account_sid, auth_token
			def ffcaller(calledNumber)
			call = @client.calls.create(
			   to: calledNumber,
			   from: "+12019928984",
			   url: "https://handler.twilio.com/twiml/EHe5881b22b8f52a84a6b22a72c2882d39")
			puts call.to
			end
			string= "+1#{9566386258}"
			ffcaller(string)
		end
	end
	get '/' do
		stats = Sidekiq::Stats.new
		workers = Sidekiq::Workers.new
		"
		testing
		<p>Processed: #{stats.processed}</p>
		<p>In Progress: #{workers.size}</p>
		<p>Enqueued: #{stats.enqueued}</p>
		<p><a href='/'>Refresh</a></p>
		<p><a href='/add_job'>Add Job</a></p>
		<p><a href='/sidekiq'>Dashboard</a></p>
		"
	end

	get '/add_job' do
		"
		<p>Added Job: #{TestWorker.perform_async(20)}</p>
		<p><a href='/'>Back</a></p>
		"
	end
end
