require 'spec_helper'

describe "Static pages" do

	
	 
  subject { page }

  describe "Home page" do
  
    before { visit root_path }
	

    it { should have_content('Games Exchange') }
  
    it { should_not have_title('| Home') }
	
	describe "for signed-in users" do
      let!(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:game, user: user, name: "Lorem ipsum", console: "dat box", location: "here")
        FactoryGirl.create(:game, user: user, name: "Dolor sit amet", console: "da thing", location: "nowhere")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.name, text: item.console, text: item.location)
        end
      end
	
  end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
   
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
   
  end
  
  
 end 
  
