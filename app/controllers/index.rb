get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/tweet' do
	text = params[:text]

	TWITTER_CLIENT.update(text)

	redirect '/'
end