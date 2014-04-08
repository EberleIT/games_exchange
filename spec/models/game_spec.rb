require 'spec_helper'

describe Game do
   let!(:user) { FactoryGirl.create(:user) }
	before { @game = user.games.build(name: "Lorem ipsum", location: "present location", console: "present sys") }
  


	subject { @game }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:location) }
  it { should respond_to(:user) }
  it { should respond_to(:console) }
   its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @game.user_id = nil }
    it { should_not be_valid }
  end
  
 
  describe "with blank content" do
    before { @game.location = " " }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @game.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @game.name = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "with console that is too long" do
    before { @game.console = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "with location that is too long" do
    before { @game.location = "a" * 141 }
    it { should_not be_valid }
  end
  
	
end