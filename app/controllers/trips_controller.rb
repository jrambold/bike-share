# Defines Trips Controller
class TripsController < ApplicationController
  def index
    limit = 30
    @pages = (Trip.all.size.to_f / limit).ceil
    offset = params[:offset].to_i * limit ||= 0
    @trips = Trip.all.offset(offset).limit(limit)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    @most_conditions = Condition.most_rides
    @least_conditions = Condition.least_rides
  end
end
