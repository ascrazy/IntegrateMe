module Api
  class CompetitionsController < BaseController
    def create
      CreateCompetition.new.call(competition_params)
      result = CreateCompetition.new.call(entry_params)
      render json: result, status: result[:success] ? 200 : 400
    end

    def competition_params
      params.require(:competition).permit(
        :name,
        :requires_entry_name,
        :runner_email,
        :mail_chimp_api_key,
        :mail_chimp_list_id
      )
    end
  end
end
