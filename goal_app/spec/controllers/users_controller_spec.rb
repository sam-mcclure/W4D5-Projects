require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new user page" do
      get :new
      expect(response).to render_template('new')
    end
  end
  
  describe "POST #create" do 
    context "with invalid params" do
      it "validates the presence of title and body" do
        post :create, params: { user: { username: "", password: ""}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
    
    context "with valid params" do
      it "redirects to goals index page" do
        post :create, params: { user: { username: "User", password: "password"}}
        expect(response).to redirect_to(goals_url)
      end
    end
  end
end
