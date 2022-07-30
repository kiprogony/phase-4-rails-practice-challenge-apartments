class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def create 
    my_lease = Lease.create!(lease_params)
    render json: my_lease
  end

  def destroy
    Lease.find(params[:id]).destroy
    render json: {}, status: :ok
  end

  private

  def lease_params
    params.permit(:lease).permit(:rent, :apartment_id, :tenant_id)
  end

  def render_record_not_found
    render json: {error: "Lease not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages}, status: :unprocessable_entity
  end
end
