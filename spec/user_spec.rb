require 'user'

describe User do
  it { is_expected.to have_property :id }
  it { is_expected.to have_property :user_name }
  it { is_expected.to have_property :email }
  it { is_expected.to have_property :password_digest }
  it { is_expected.to validate_presence_of :user_name }
  it { is_expected.to validate_length_of(:user_name). max(25) }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_format_of(:email).with(:email_address) }
  it { is_expected.to validate_uniqueness_of :email }
end

describe "Password encryption" do
      it "Encrypts password" do
      user = User.create(user_name: "chrisco", email: "git.chrisco@gmail.com", password: "right", password_confirm: "right")
      expect(user.password_digest.class).to eq BCrypt::Password
      expect(user.password_digest.version).to eq "2a"
      end
  end

  describe "User authentication" do
    before do
      @user = User.create(user_name: "chrisco", email: "git.chrisco@gmail.com", password: "right", password_confirm: "right")
    end

    it "With valid credentials" do
      expect(User.authenticate("git.chrisco@gmail.com", "right")).to eq @user
    end

    it "With INVALID credentials" do
      expect(User.authenticate("git.chrisco@gmail.com", "wrong")).to eq nil
    end
  end
