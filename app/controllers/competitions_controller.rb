class CompetitionsController < ApplicationController
  def entrant_page
    @entry = Entry.new(competition: Competition.find(params[:competition_id]))
  end

  def show
    @competition = Competition.find(params[:id])
  end
end
