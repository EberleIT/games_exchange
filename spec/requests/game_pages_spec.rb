require 'spec_helper'


describe "Game pages" do

  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "game creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a game" do
        expect { click_button "Post" }.not_to change(Game, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before  do
	  fill_in 'game_name', with: "Lorem ipsum" 
	  fill_in 'game_location', with: "Lorem ipsum" 
	  fill_in 'game_console', with: "Lorem ipsum" 
	  end

      it "should create a game" do
        expect { click_button "Post" }.to change(Game, :count).by(1)
      end
    end
  end

  
  
  end