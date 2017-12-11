class StatisticsController < ApplicationController

  before_action :ensure_signed_in
  before_action :load_statistics, only: [:index, :show, :edit, :update, :destroy]

  def new
    @statistic = Statistic.new
  end

  def index
    @statistic = Statistic.find_by(user_id: params[:id])
  end

  def create
    @statistic = Statistic.new(create_params)
    @statistic.user = current_user

    if @statistic.save
      flash[:notice] = 'Stats recorded!'
      redirect_to statistics_path(@statistic)
    else
      flash[:error] = @statistic.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
    if @statistic.update(update_params)
      flash[:notice] = 'Statistic updated!'
      redirect_to satistics_path(@statistic)
    else
      flash[:error] = @statistic.errors.full_messages.join(', ')
      render :edit
    end
  end


  def show
    @statistic = Statistic.find_by(user_id: params[:id])
  end

  def destroy
    @statistic.destroy!

    flash[:notice] = "#{@statistic.name} deleted!"
    redirect_to user_path
  end

  private

  def create_params
    params.require(:user_id).permit(:wins, :loss)
  end

  def update_params
    params.require(:user_id).permit(:wins)
  end

  def load_statistics
    @statistic = Statistic.find_by(user_id: params[:id])
  end
end
