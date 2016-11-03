class Admin::LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Location.search(params[:q])
    @locations = @search.result
    @search.build_condition
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    if @location.save
      flash[:success] = t :success
      redirect_to admin_category_path @location.category
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update_attributes location_params
      flash[:success] = t :locationupdated
      redirect_to admin_locations_path
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    flash[:danger] = t :destroyed
    redirect_to admin_locations_path
  end

  private
  def location_params
    params.require(:location).permit :name, :introduction, :category_id,
      :picture, :address
  end
end
