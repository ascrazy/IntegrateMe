require "rails_helper"

describe CompetitionsHelper do
  describe "#competition_entrant_path" do
    it "should create permalinks for competitions" do
      competition = Competition.create!(id: 99, name: "My Competition!")
      expect(helper.competition_entrant_path(competition)).to eq("/99/my-competition")
     end
  end
end
