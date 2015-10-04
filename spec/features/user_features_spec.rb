feature "Sign Up" do
  before do
    visit "sign_up"
  end

  scenario "Render sign-up form" do
    expect(page).to have_selector "form[action='/sign_up']"
    expect(page).to have_selector "form[method='post']"
    expect(page).to have_selector "input[name='user_name']"
    expect(page).to have_selector "input[name='email']"
    expect(page).to have_selector "input[name='password']"
    expect(page).to have_selector "input[name='password_confirm']"
    expect(page).to have_selector :link_or_button, "Sign Up"
  end

  scenario "Create a new user when valid inputs are submitted" do
    expect(User.count).to eq 0
    fill_in "user_name", with: "chrisco"
    fill_in "email", with: "git.chrisco@gmail.com"
    fill_in "password", with: "right"
    fill_in "password_confirm", with: "right"
    click_button "Sign Up"
    expect(User.count).to eq 1
  end

    # TODO: Test for missing or invalid inputs and flash
    scenario "Do NOT create a new user when INVALID inputs are submitted" do
    expect(User.count).to eq 0
    fill_in "user_name", with: ""
    fill_in "email", with: "git.chrisco@gmail.com"
    fill_in "password", with: "right"
    fill_in "password_confirm", with: "right"
    click_button "Sign Up"
    expect(User.count).to eq 0›
    expect(page).to have_content "You submitted invalid data.  Please try again."
  end
end

feature "Sign In" do
  before do
    visit "/sign_in"
  end

  scenario "Render sign-in form" do
    expect(page).to have_selector "form[action='/sign_in']"
    expect(page).to have_selector "form[method='post']"
    expect(page).to have_selector "input[name='email']"
    expect(page).to have_selector "input[name='password']"
    expect(page).to have_selector :link_or_button, "Sign In"
  end

scenario "Allow registered user to sign in when valid inputs are submitted" do
    create_and_login_user("git.chrisco@gmail.com", "password")
    expect(page.current_path).to eq "/"
    expect(page).to have_content "Welcome Chris!"
  end
end

feature "Sign Out" do
  scenario "When signed-in users click the 'Sign Out' button, they are signed out" do
    create_and_login_user("git.chrisco@gmail.com", "password")
    visit "/sign_out"
    expect(page).to have_content "Catch ya later, alligator!"
  end
end
›