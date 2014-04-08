require 'spec_helper'

describe User do
  before do
    @user = User.new(username: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  subject { @user }
  
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }  
  it { should respond_to(:admin) }
 it { should respond_to(:games) }
 it { should respond_to(:feed) }
  
  
  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end
 
  

  it { should be_valid }
  
  
  describe "when name is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email format is valid" do
    valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    valid_addresses.each do |valid_address|
      before {@user.email = valid_address }
      it { should be_valid}
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " "}
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  
  describe "game associations" do

    before { @user.save }
    let!(:older_game) do
      FactoryGirl.create(:game, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_game) do
      FactoryGirl.create(:game, user: @user, created_at: 1.hour.ago)
    end

	describe "listings" do
      let(:unfollowed_post) do
        FactoryGirl.create(:game, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_game) }
      its(:feed) { should include(older_game) }
      its(:feed) { should_not include(unfollowed_post) }
    end
	
    it "should have the right games in the right order" do
      expect(@user.games.to_a).to eq [newer_game, older_game]
    end
	
	it "should destroy associated games" do
      games = @user.games.to_a
      @user.destroy
      expect(games).not_to be_empty
      games.each do |game|
        expect(Game.where(id: game.id)).to be_empty
      end
    end
	
	
  end
  
  
  
  
  
 
end