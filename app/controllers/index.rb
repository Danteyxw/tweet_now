get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/tweet' do
	erb :tweet
end

get '/logout' do
	session[:user] = nil

	redirect '/'
end

post '/twitter/signin' do
	if session[:user] == nil
		redirect '/auth/twitter'
	else
		redirect '/tweet'
	end
end

get '/auth/twitter/callback' do
	env["omniauth.auth"] ? @username = env["omniauth.auth"]["info"]["name"] : halt(401, "Not Authorized")
	session[:user] = @username
	@access_token = env["omniauth.auth"]["credentials"]["token"]
	@access_secret = env["omniauth.auth"]["credentials"]["secret"]

	User.create(username: @username, access_token: @access_token, access_secret: @access_secret)

	redirect '/tweet'
end

post '/tweet' do
	user = User.find_by(username: session[:username])

	TWITTER_CLIENT.access_token = user.access_token
	TWITTER_CLIENT.access_token_secret = user.access_secret

	text = params[:text]

	if text != ""
		TWITTER_CLIENT.update(text)
	end
end