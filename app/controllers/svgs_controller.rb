class SvgsController < ApplicationController

  def create
    Svg.find_or_create_by_name params[:svg]

    render json: { status: "okay" }
  end


end
