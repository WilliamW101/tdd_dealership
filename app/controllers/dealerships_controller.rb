class DealershipsController < ApplicationController
  before_action :set_dealership, except: [:index, :new, :create]

  def index
    @dealerships = Dealership.all.limit(2)
  end

  def new
    @dealership = Dealership.new
  end

  def create
    @dealership = Dealership.new(dealership_params)
    if @dealership.save
      flash[:success] = 'Dealership Created'
      redirect_to dealership_path(@dealership)
    else
      flash[:error] = 'Fix errors and try again'
      render :new
    end
  end

  def show
  end

  def update
    if @dealership.update(dealership_params)
      flash[:success] = 'Dealership Updated'
      redirect_to dealership_path(@dealership)
    else
      flash[:error] = 'Dealership failed to update'
      render :edit
    end
  end

  def edit
  end

  def destroy
    @dealership.destroy
    flash[:success] = 'Dealership Deleted'
    redirect_to dealerships_path
  end

  private

  def dealership_params
   params.require(:dealership).permit(:name, :inventory)
 end

  def set_dealership
    @dealership = Dealership.find(params[:id])
  end
end
