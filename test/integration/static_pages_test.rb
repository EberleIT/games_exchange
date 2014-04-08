require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Games Exchange'" do
      visit '/static_pages/home'
      expect(page).to have_content('Games Exchange')
    end
  end
end
end
