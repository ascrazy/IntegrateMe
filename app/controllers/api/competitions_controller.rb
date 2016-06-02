module Api
  class CompetitionsController < BaseController
    def create
      result = CreateCompetition.new(
        mail_chimp_adapter_klass: MailChimpAdapter::GibbonAdapter
      ).call(competition_params)
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
