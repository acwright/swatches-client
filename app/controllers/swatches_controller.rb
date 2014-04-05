class SwatchesController < ApplicationController
  respond_to :html

  def index
    @swatches = Swatch.all
    respond_with @swatches
  end

  def new
    @swatch = Swatch.new
    respond_with @swatch
  end

  def create
    @swatch = Swatch.create(swatch_params)
    respond_with @swatch, :location => swatches_path
  end

  def edit
    @swatch = Swatch.find(params[:id])
    respond_with @swatch
  end

  def update
    @swatch = Swatch.update(params[:id], swatch_params)
    respond_with @swatch, :location => swatches_path
  end

  def destroy
    @swatch = Swatch.destroy(params[:id])
    respond_with @swatch
  end

  private

  def swatch_params
    params.require(:swatch).permit!
  end
end
