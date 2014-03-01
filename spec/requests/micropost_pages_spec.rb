require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin(user) }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error message" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as another user" do
      let(:another_user) { FactoryGirl.create(:user) }
      #let(:micropost)    { FactoryGirl.create(:micropost, user: another_user, content: "Super Message" ) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Super Message" )
        valid_signin(another_user)
        visit user_path(user)
      end

      it { should_not have_link('delete') }
      it { should have_content('Super Message') }
    end
  end
end
