require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    describe "GET /static_pages/home.html" do
      it "works! (now write some real specs)" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        get static_pages_home_path
        response.status.should be(200)
      end
    end
    describe "Home Page Content" do
      it "should have the content 'Sample App'" do
        visit static_pages_home_path
        page.should have_content('Sample App')
      end
      it "should have the h1 'Sample App'" do
        visit static_pages_home_path
        page.should have_selector('h1', :text => 'Sample App')
      end
      it "should have the title 'Home'" do
        visit static_pages_home_path
        page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Home")
      end
    end
  end

  describe "Help Page" do
    describe "GET /static_pages/help.html" do
      it "works! (now write some real specs)" do
        get static_pages_help_path
        response.status.should be (200)
      end
    end
    describe "Help Page Content" do
      it "should have the content 'Help'" do
        visit static_pages_help_path
        page.should have_content('Help')
      end
      it "should have the h1 'Help'" do
        visit static_pages_help_path
        page.should have_selector('h1', :text => 'Help')
      end
      it "should have the title 'Help'" do
        visit static_pages_help_path
        page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Help")
      end
    end
  end

  describe "About Page" do
    describe "GET /static_pages/about.html" do
      it "works! (now write some real specs)" do
        get static_pages_about_path
        response.status.should be (200)
      end
    end
    describe "About Page Content" do
      it "should have the content 'About Us'" do
        visit static_pages_about_path
        page.should have_content('About Us')
      end
    end
    it "should have the h1 'About Us'" do
      visit static_pages_about_path
      page.should have_selector('h1', :text => 'About Us')
    end
    it "should have the title 'About Us'" do
      visit static_pages_about_path
      page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | About Us")
    end
  end
end
