class UsersController < ApplicationController
  before_action :validate_campaign_names, only: :filter

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def filter
    begin
      campaign_names = params[:campaign_names].split(',')
      @users = User.where(
        campaign_names.map { |name|
          "JSON_CONTAINS(campaigns_list, '{\"campaign_name\": \"#{name}\"}', '$')"
        }.join(' OR ')
      )
      render json: @users
      rescue
        render status: :bad_request
      end
  end

  private

  def user_params
    params.permit(:name, :email, campaigns_list: [:campaign_name, :campaign_id])
  end

  def validate_campaign_names
    if params[:campaign_names].blank?
      render json: { error: 'campaign_names parameter is required' }, status: :bad_request
    elsif !params[:campaign_names].is_a?(String)
      render json: { error: 'campaign_names parameter must be a comma-separated string' }, status: :bad_request
    end
  end
end

