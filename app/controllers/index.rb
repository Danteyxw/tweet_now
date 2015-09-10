get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/auth' do
	
end

get '/tweet' do
	erb :tweet
end

post '/twitter/signin' do
	redirect '/auth/twitter'
end

get '/auth/twitter/callback' do
	env["omniauth.auth"] ? session[:user] = env["omniauth.auth"]["info"]["name"] : halt(401, "Not Authorized")
	@access_token = env["omniauth.auth"]["credentials"]["token"]
	@access_secret = env["omniauth.auth"]["credentials"]["secret"]
	$twitter_client.access_token = @access_token
+	$twitter_client.access_token_secret = @access_secret
	redirect '/tweet'
end

post '/tweet' do
	text = params[:text]

	if text != ""
		TWITTER_CLIENT.update(text)
	end
end