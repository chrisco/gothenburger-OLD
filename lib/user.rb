require "bcrypt"
require 'data_mapper'

class User

  attr_accessor :password, :password_confirm

  include DataMapper::Resource
  include BCrypt

  property :id,                Serial
  property :user_name,         String, length: 255, unique: true, message: "This user name is already taken" # TODO: Flash
  property :email,             String, format: :email_address, unique: true, message: "This email is already taken" # TODO: Flash
  property :password_digest,   Text, length: 255
  property :created_at,        DateTime

  validates_presence_of        :user_name
  validates_length_of          :user_name, maximum: 25
  validates_presence_of        :email

  before :save do
    if self.password == self.password_confirm
      self.password_digest = BCrypt::Password.create(self.password)
    else
      break # TODO: What should we do here? Flash. What else (if anything)?
    end
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  # From Thomas: https://github.com/tochman/my_app/blob/master/lib/user.rb#L39
  def is_owner?(obj)
    obj.user_id == self.id
  end

end
