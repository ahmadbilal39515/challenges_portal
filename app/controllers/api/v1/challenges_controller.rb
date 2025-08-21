class Api::V1::ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[ show update destroy edit]
  
  def index
    @challenges = Challenge.all
    render json: @challenges
  end

  def show
    if @challenge
      render json: { message: "Challenge found", data: @challenge}
    else
      render json: { message: "Challenge not found", data: @challenge.errors}
    end
  end

  def edit
    render json: { data: @challenge }
  end

  def create
    challenge = Challenge.new(challenges_params)
    if challenge.save
      render json: { message: 'Challenge added successfully', data: challenge}
    else
      render json: { message: 'Failed to add challenge', data: challenge.errors}
    end
  end

  def update
    challenge = @challenge.update(challenges_params)
    if challenge.update
      render json: { message: 'Challenge updated successfully', data: challenge}
    else
      render json: { message: 'Failed to update challenge', data: challenge.errors}
    end
  end

  def destroy
    if @challenge.destroy
      render json: { message: "Challenge deleted", data: @challenge}
    else
      render json: { message: "Challenge Failed to delete", data: @challenge.errors}
    end
  end

  private
  
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenges_params
    params.require(:challenge).permit(:title, :description, :start_date, :end_date)
  end
end