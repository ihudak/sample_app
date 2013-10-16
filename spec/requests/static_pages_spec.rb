require_relative '../spec_helper'

describe "StaticPages" do

  subject { page }
  describe "Home Page" do
    before { visit root_path }
    it { should     have_content('Home') }
    it { should     have_selector('h1', text: 'Sample App') }
    it { should     have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: '| Home') }
  end

  describe "Help Page" do
    before { visit help_path }
    it { should     have_content('Help') }
    it { should     have_selector('h1', text: 'Help') }
    it { should     have_selector('title', text: full_title('Help')) }
  end

  describe "About Page" do
    before { visit about_path }
    it { should     have_content('About Us') }
    it { should     have_selector('h1', text: 'About Us') }
    it { should     have_selector('title', text: full_title('About Us')) }
  end

  describe "Contacts Page" do
    before { visit contacts_path }
    it { should     have_content('Contact Us') }
    it { should     have_selector('h1', text: "Contact Us") }
    it { should     have_selector('title', text: full_title('Contact Us')) }
  end
end
