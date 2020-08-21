class CategoryController < ApplicationController
  before_action :authorized

  def sample
    render :json => {
        :response => 'look at this endpoint'
    }
  end

  def index
    @category = Category.all
    if @category.empty?
      render json: {
          'error': 'no data here'
      }
    else
      render :json => {
          :response => 'successful',
          :data => @category
      }
    end
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      render :json => {
          :response => 'successfully created',
          :data => @new_category
      }
    else
      render :json => {
          :error => 'cant save input'
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => 'successful',
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => 'category not found'
      }
    end
  end

  def update
    if(@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'successfully updated',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'cannot update'
      }
    end
  end

  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?
      @category_delete.destroy
      render :json => {
          :response => 'successfully deleted'
      }
    else
      render :json => {
          :response => 'cannot delete'
      }
    end
  end

  private
  def category_params
    params.permit(:id, :title, :description, :created_by)
  end
end
