class ApartmentsController < ApplicationController

  def index
    render json: Apartment.all
  end

  def show
    render json: get_apartment
  end

  def update
    apartment = get_apartment.update(apartment_params)
    if apartment
      render json: get_apartment
    else  
      render json: { error: "Could not update"}, status: :forbidden
    end
  end

  def create
    apartment = Apartment.create(apartment_params)
    render json: apartment
  end

  def destroy
    get_apartment.destroy
    head :no_content
  end

  private

  def get_apartment
    Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(:number)
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages}, status: :unprocessable_entity 
  end
end
