# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Test User 1", email: "test.user1@test.com",
                            password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  describe "respond to properties and methods" do
    subject { @user }

    it { should respond_to(:name)  }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:admin) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:microposts) }
    it { should respond_to(:feed) }
  end

  it { should be_valid }
  it { should_not be_admin }

  describe "when the name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end

  describe "when the name is too long" do
    before { @user.name = "a" * 51 }
    it {should_not be_valid }
  end

  describe "when the name length is fine" do
    before { @user.name = "a" * 50 }
    it {should be_valid }
  end

  describe "when the email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "when the email is too long" do
    before { @user.email = "a@a." + "a" * 121 + ".com" }
    it {should_not be_valid }
  end

  describe "when the email length is fine" do
    before { @user.email = "a@a." + "a" * 120 + ".com" }
    it {should be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com mail@csg]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_dup_email = @user.dup
      user_with_dup_email.email = @user.email.upcase
      user_with_dup_email.name = "user2"
      user_with_dup_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password_confirmation is not the same as the password" do
    before { @user.password_confirmation = "another_password" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should_not be_valid }
  end

  describe "return value of authentication method" do
    before do
      @user.password_confirmation = @user.password
      @user.save
    end

    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it {should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid_pwd") }

      it { should_not == user_for_invalid_password }
      specify {user_for_invalid_password.should be_false }
    end
  end

  describe "email address  with mixed case" do
    let (:mixed_case_email) { "MaiL@eXamPLE.COm" }

    it "should have be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "remember token" do
    before {@user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: false)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "microposts associations" do
    before { @user.save }
    let!(:older_micropost) { FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago) }
    let!(:newer_micropost) { FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago) }

    it 'should have the right microposts in the right order' do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it 'should destroy associated microposts' do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_post) { FactoryGirl.create(:micropost, user: FactoryGirl.create(:user)) }

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end
end
