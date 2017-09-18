class PlantsController < ApplicationController
  before_action :ensure_logged_in

  def index
    plants = current_user.plants
    wetPlants = plants.select { |plant| plant.category == 'Heavy' }
    @wetCount = wetPlants.count
    mediumPlants = plants.select { |plant| plant.category == 'Medium' }
    @mediumCount = mediumPlants.count
    dryPlants = plants.select { |plant| plant.category == 'Light' }
    @dryCount = dryPlants.count
  end

  def show
    @plant = current_user.plants.find(params[:id])
  end

  def new
    @categories = ['Light', 'Medium','Heavy']
    @sizes = ['Small', 'Medium', 'Large']
    @conditions = ['Poor', 'Ok', 'Healthy']
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(create_params)
    @plant.user = current_user

    if @plant.save
      flash[:notice] = 'Added Plant'
      redirect_to users_path
    else
      flash[:error] = @plant.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    plant = current_user.plants.find(params[:id])
    plant.destroy!
    flash[:notice] = "#{plant.name} deleted"
    redirect_to plants_path
  end

  def dry
    plants = current_user.plants
    @plants = plants.select { |plant| plant.category == 'Light' }
  end

  def medium
    plants = current_user.plants
    @plants = plants.select { |plant| plant.category == 'Medium' }
  end

  def wet
    plants = current_user.plants
    @plants = plants.select { |plant| plant.category == 'Heavy' }
  end

  private

  def create_params
    params.require(:plant).permit(:name, :category, :size, :condition)
  end

  def update_params
    params.require(:plant).permit(:name, :category, :size, :condition)
  end
end
