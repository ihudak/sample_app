require_relative '../spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(content) }
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  shared_examples_for "primary static pages" do | page_cont |
    let(:content)    { page_cont }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector('title', text: "| #{content}") }
  end

  shared_examples_for "secondary static pages" do | page_cont |
    let(:content)    { page_cont }
    let(:heading)    { page_cont }
    let(:page_title) { page_cont }

    it_should_behave_like "all static pages"
    it { should have_selector('title', text: content) }
  end

  describe "Home Page" do
    before { visit root_path }
    it_should_behave_like "primary static pages", 'Home'

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        31.times { FactoryGirl.create(:micropost, user: user) }
        valid_signin(user)
        visit root_path
      end

      after { user.microposts.delete_all }

      it "should render the user's feed" do
        user.feed[1..29].each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      it "should have micropost count and pluralization" do
        page.should have_content('31 microposts')
      end

      it "should paginate after 30" do
        page.should have_selector('div.pagination')
      end
    end
  end

  describe "Help Page" do
    before { visit help_path }
    it_should_behave_like "secondary static pages", 'Help'
  end

  describe "About Page" do
    before { visit about_path }
    it_should_behave_like "secondary static pages", 'About Us'
  end

  describe "Contacts Page" do
    before { visit contacts_path }
    it_should_behave_like "secondary static pages", 'Contact Us'
  end

  it "should have the right links on the layout" do
    visit root_path
    should have_selector 'title', text: full_title('')
    should_not have_selector 'title', text: 'Home'
    click_link "About"
    should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    should have_selector 'title', text: full_title('Contact Us')
    click_link "Home"
    should have_selector 'title', text: full_title('')
    should_not have_selector 'title', text: 'Home'
    click_link "Sign up now!"
    should have_selector 'title', text: 'Sign up'
    click_link "sample app"
    should have_selector 'title', text: full_title('')
    should_not have_selector 'title', text: 'Home'
  end
end
