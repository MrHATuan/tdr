class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find_by_id params[:id]
      obj.rate params[:score].to_f, current_user, params[:dimension]
      rate = if obj.rates("service").size == 1
        obj.rates("service").first.stars
      else
        obj.average("service").avg
      end
      obj.update_attributes rating: rate.round(2)

      render json: true
    else
      render json: false
    end
  end
end