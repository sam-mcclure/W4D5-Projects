class GoalsController < ApplicationController
  def new
    render 'new'
  end
  
  def show
    @goal = Goal.find_by(id: params[:id])
    render 'show'
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end 
  end

  def index
    @goals = Goal.all.to_a
    @goals.select! {|goal| goal.public == true || goal.user_id == current_user.id}
    render :index
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
    render :edit
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else 
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end 
  end
  
  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    redirect_to goals_url
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:title, :public, :completed)
  end 
end
