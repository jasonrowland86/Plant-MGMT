class PlantsController < ApplicationController
  before_action :ensure_logged_in

  def index
    
  end

  def show
    @plant = current_user.plants.find(params[:id])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(create_params)
    @plant.user = current_user

    if @plant.save
      flash[:notice] = 'Added plant'
      redirect_to users_path
    else
      flash[:error] = @plant.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    plant = current_user.plants.find(params[:id])
    plant.destroy!
    flash[:notice] = "#{plant.name} removed!"
    redirect_to users_path
  end

  private

  def create_params
    params.require(:plant).permit(:name, :category, :size, :condition)
  end

  def update_params
    params.require(:plant).permit(:name, :category, :size, :condition)
  end
end
