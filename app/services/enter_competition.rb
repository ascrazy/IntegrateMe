class EnterCompetition
  def initialize(mail_chimp_adapter:)
    @mail_chimp_adapter = mail_chimp_adapter
  end

  def call(params)
    entry = Entry.new(params)
    if entry.valid?
      entry.save
      sync_to_mail_chimp(entry)
      { success: true }
    else
      { success: false, errors: entry.errors }
    end
  end

  private

  attr_reader :mail_chimp_adapter

  def sync_to_mail_chimp(entry)
    mail_chimp_adapter.add_member_to_list(
      entry.competition.mail_chimp_list_id,
      email: entry.email,
      name: entry.name
    )
    entry.update(sync_status: 'synced')
  rescue MailChimpAdapter::MailChimpError => err
    Rails.logger.error("Failed to sync new entry to MailChimp. #{err.message}")
    entry.update(sync_status: 'failed')
    SystemMailer.notify_failed_synchronization(
      entry.competition.runner_email,
      err.message,
      entry
    )
  rescue => err
    Rails.logger.error("Failed to send sync failure email. #{err.message}")
  end
end
