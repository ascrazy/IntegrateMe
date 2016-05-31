class MailChimpAdapter
  def initialize(api_key)
    @gibbon = Gibbon::Request.new(api_key: api_key, debug: Rails.env.development?)
  end

  def all_lists
    gibbon.lists.retrieve
  rescue Gibbon::MailChimpError => err
    raise MailChimpAdapter::MailChimpError.new(err)
  end

  def find_list(list_id)
    response = gibbon.lists(list_id).retrieve
  rescue Gibbon::MailChimpError => err
    raise MailChimpAdapter::MailChimpError.new(err)
  end

  def add_member_to_list(list_id, member)
    gibbon.lists(list_id).members(Digest::MD5.hexdigest(member.email)).upsert(
      body: {
        email_address: member.email,
        status: 'subscribed',
        merge_fields: { NAME: 'First Name', LNAME: 'Last Name' }
      }
    )
  rescue Gibbon::MailChimpError => err
    raise MailChimpAdapter::MailChimpError.new(err)
  end

  private

  attr_reader :gibbon
end
