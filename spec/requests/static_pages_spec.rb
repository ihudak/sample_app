require_relative '../spec_helper'

describe "StaticPages" do

  let(:base_title) {"Ruby on Rails Tutorial App"}

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
        page.should have_selector('title', :text => "#{base_title} | Home")
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
        page.should have_selector('title', :text => "#{base_title} | Help")
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
      page.should have_selector('title', :text => "#{base_title} | About Us")
    end
  end

  describe "Contacts Page" do
    describe "GET /static_pages/contacts.html" do
      it "works! (now write some real specs)" do
        get static_pages_contacts_path
        response.status.should be (200)
      end
    end
    describe "Contacts Page Content" do
      it "should have the content 'Contact Us'" do
        visit static_pages_contacts_path
        page.should have_content('Contact Us')
      end
      it "should have the h1 'Contact Us'" do
        visit static_pages_contacts_path
        page.should have_selector('h1', :text => "Contact Us")
      end
      it "should have the title 'Contact Us'" do
        visit static_pages_contacts_path
        page.should have_selector('title', :text => "#{base_title} | Contact Us")
      end
    end
  end
end
