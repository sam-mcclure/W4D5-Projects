require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do 
    visit new_user_url
  end
  
  scenario 'has a new user page' do   
    expect(page).to have_content('Sign Up')
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do 
      fill_in 'Username', with: 'Jim'
      fill_in 'Password', with: 'password'
      click_button 'Create User'
      
      expect(page).to have_content('Jim')
    end

  end
end

feature 'logging in' do
  background :each do
    visit new_session_url
  end
  scenario 'shows username on the homepage after login' do 
    User.create(username: 'Jim', password: 'password')
    fill_in 'Username', with: 'Jim'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    
    expect(page).to have_content('Jim')
  end
end

feature 'logging out' do
  
  background :each do
    visit new_session_url
  end
  
  scenario 'begins with a logged out state' do 
    expect(page).to have_content('Sign In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    User.create(username: 'Jim', password: 'password')
    fill_in 'Username', with: 'Jim'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    
    click_button 'Sign Out'
    expect(page).to_not have_content('Jim')
  end

end













