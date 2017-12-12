class StatisticsController < ApplicationController

  before_action :ensure_signed_in
  before_action :load_statistics, only: [:index, :show, :edit, :update, :destroy, :new]

  def new
    @statistic = Statistic.new
    @user = current_user
  end

  def index
    @statistic = Statistic.where(user_id: params[:user_id])
  end

  def create
    @statistic = Statistic.new(create_params)
    @statistic.user = current_user

    if @statistic.save
      flash[:notice] = 'Stats recorded!'
      redirect_to user_statistics_path
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
    @statistic = Statistic.find_by(id: params[:id])
  end

  def destroy
    @statistic.destroy!

    flash[:notice] = "#{@statistic.name} deleted!"
    redirect_to user_path
  end

  private

  def create_params
    params.require(:statistic).permit(:sleep, :happiness, :energy, :stress, :optimism, :wins, :losses)
  end

  def update_params
    params.require(:user_id).permit(:wins)
  end

  def load_statistics
    @statistic = Statistic.find_by(user_id: params[:id])
  end
end
