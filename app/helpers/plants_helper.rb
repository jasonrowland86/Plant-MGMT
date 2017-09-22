module PlantsHelper

  def state_type
    if @plant.category == "Light"
       "This plant is dry adapted and should be watered every 2 weeks"
    elsif @plant.category == "Medium"
       "This plant preferes to be slightly moist and should be watered once a week"
    elsif @plant.category == "Heavy"
       "This plant loves staying wet and should be watered every 3-4 days"
    end
  end

end
