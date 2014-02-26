include ApplicationHelper

def valid_signin(user)
  visit signin_path
  fill_in "Email",           with: user.email
  fill_in "Password",        with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

def valid_registration
  fill_in "Name",             with: "Example User"
  fill_in "Email",            with: "user@example.com"
  fill_in "Password",         with: "foobar"
  fill_in "Confirmation",     with: "foobar"
end

def valid_update(user, new_name="", new_email="")
  fill_in "Name",             with: new_name.empty? ? user.name : new_name
  fill_in "Email",            with: new_email.empty? ? user.email : new_email
  fill_in "Password",         with: user.password
  fill_in "Confirm Password", with: user.password
  click_button "Save changes"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end
