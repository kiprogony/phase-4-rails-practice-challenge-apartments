class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    render json: Tenant.all
  end

  def show
    render json: get_tenant
  end

  def update
    tenant = get_tenant.update(tenant_params)
    if tenant
      render json: get_tenant
    else  
      render json: { error: "Could not update"}, status: :forbidden
    end
  end

  def create
    tenant = Tenant.create(tenant_params)
    render json: tenant
  end

  def destroy
    get_tenant.destroy
    head :no_content
  end

  private

  def get_tenant
    Tenant.find(params[:id)
  end

  def tenant_params
    params.require(:apartment).permit(:name, :age)
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages}, status: :unprocessable_entity 
  end

  def render_record_not_found
    render json: { error: "Tenant not found" }, status: :not_found
  end

  # def unpermitted_params
  #   render json: {error: "unpermitted parameters"}
  # end
end
