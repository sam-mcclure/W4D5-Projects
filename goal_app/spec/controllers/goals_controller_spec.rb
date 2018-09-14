require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do 
      it "creates the goal and redirects to goal's show page" do
        user = User.create(username: "Jim", password: "password")
        allow(controller).to receive(:current_user) { user }
        post :create, params: {goal: {title: 'First Goal', user_id: user.id}}
        expect(response).to redirect_to(goal_url(Goal.find_by(title: 'First Goal')))
      end
    end
  
    context "with invalid params" do
      it "shows errors and renders new again" do
        user = User.create(username: "Jim", password: "password")
        allow(controller).to receive(:current_user) { user }
        post :create, params: {goal: {title: ''}}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "PATCH #update" do
    context "with valid params" do
      it "should redirect to the goal show page" do
        user = User.create(username: "Jim", password: "password")
        allow(controller).to receive(:current_user) { user }
        goal = Goal.create(title: 'First Goal', user_id: user.id)
        patch :update, params: { id: goal.id, goal: {title: 'New Goal' } }
        expect(response).to redirect_to(goal_url(Goal.find_by(title: 'New Goal')))
      end
    end
  
    context "with invalid params" do
      it "renders edit and adds errors" do
        user = User.create(username: "Jim", password: "password")
        allow(controller).to receive(:current_user) { user }
        goal = Goal.create(title: 'First Goal', user_id: user.id)
        patch :update, params: { id: goal.id, goal: {title: '' } }
        expect(response).to render_template('edit')
      end
    end
   end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    
    it "redirects to goals index" do
      user = User.create(username: "Jim", password: "password")
      allow(controller).to receive(:current_user) { user }
      goal = Goal.create(title: 'First Goal', user_id: user.id)
      delete :destroy, params: { id: goal.id }
      expect(response).to redirect_to(goals_url)
    end
    
    it "deletes the goal" do
      user = User.create(username: "Jim", password: "password")
      allow(controller).to receive(:current_user) { user }
      goal = Goal.create(title: 'First Goal', user_id: user.id)
      delete :destroy, params: { id: goal.id }
      expect(Goal.all).to_not include(goal)
    end
  end
  
end

















