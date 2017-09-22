class PlantsController < ApplicationController
  before_action :ensure_logged_in

  def index
    plants = current_user.plants
    dryPlants = current_user.plants.where(category: 'Dry')
    moderatePlants = current_user.plants.where(category: 'Moderate')
    wetPlants = current_user.plants.where(category: 'Wet')
    @dryCount = dryPlants.count
    @moderateCount = moderatePlants.count
    @wetCount = wetPlants.count
  end

  def show
    @plant = current_user.plants.find(params[:id])
  end

  def new
    @categories = ['Dry', 'Moderate','Wet']
    @sizes = ['Small', 'Medium', 'Large']
    @conditions = ['Poor', 'Ok', 'Healthy']
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(create_params)
    @plant.user = current_user

    if @plant.save
      flash[:notice] = 'Added Plant'
      redirect_to plants_dashboard_path
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

  def moderate
    plants = current_user.plants
    @plants = plants.select { |plant| plant.category == 'Moderate' }
  end

  def wet
    plants = current_user.plants
    @plants = plants.select { |plant| plant.category == 'Heavy' }
  end

  def dashboard
    plants = current_user.plants
    dryPlants = current_user.plants.where(category: 'Dry')
    moderatePlants = current_user.plants.where(category: 'Moderate')
    wetPlants = current_user.plants.where(category: 'Wet')
    @dryCount = dryPlants.count
    @moderateCount = moderatePlants.count
    @wetCount = wetPlants.count

    @events = Event.all
    @calendar_events = @events.map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date)}
  end

  private

  def create_params
    params.require(:plant).permit(:name, :category, :size, :condition)
  end

  def update_params
    params.require(:plant).permit(:name, :category, :size, :condition)
  end
end
