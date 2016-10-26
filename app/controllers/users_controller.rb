class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @activities = PublicActivity::Activity.order(created_at: :desc)
      .where(owner_id: @user.id, owner_type: "User")
  end
end
