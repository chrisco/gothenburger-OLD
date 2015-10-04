require 'sinatra/base'
require 'sinatra/flash'
require 'data_mapper'
require 'dm-migrations'
require 'bcrypt'
require 'byebug'

class Gothenburger < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }
  enable :sessions
  register Sinatra::Flash
  set :session_secret, '123321123'
  use Rack::Session::Pool
  env = ENV['RACK_ENV'] || "development"

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/gb_#{env}")
  DataMapper.finalize
  DataMapper.auto_upgrade!
  #DataMapper.auto_migrate!
  DataMapper::Model.raise_on_save_failure = true

  get '/' do
    erb :index
  end

  get '/gallery' do
    erb :gallery
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    if((params[:email] == '') || (params[:user_name] == '') || (params[:password] == '') || (params[:password_confirm] == ''))
      flash[:warning] = "You submitted invalid data.  Please try again."
      redirect '/sign_up'
    else
      new_user = User.new
      new_user.user_name = params[:user_name]
      new_user.email = params[:email]
      new_user.password = params[:password]
      new_user.password_confirm = params[:password_confirm]
      new_user.save
      redirect '/'
    end
  end

  get '/sign_in' do
    erb :sign_in
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
