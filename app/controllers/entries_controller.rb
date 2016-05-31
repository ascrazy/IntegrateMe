class EntriesController < ApplicationController

  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render json: {success: true}
    else
      render json: {success: false, errors: @entry.errors}
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email)
    end

    def mail_chimp_adapter
      MailChimpAdapter::GibonAdapter.new(
        api_key: Rails.application.config.x.mail_chimp['api_key'],
        debug: Rails.env.development?
      )
    end
end
