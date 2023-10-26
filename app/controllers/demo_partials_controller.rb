class DemoPartialsController < ApplicationController
  def new
    @zone = t "new_action"
    @date = Time.zone.today
  end

  def edit
    @zone = t "edit_action"
    @date = Time.zone.today - 4
  end
end
