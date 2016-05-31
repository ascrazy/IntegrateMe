module MailChimpAdapter
  class GibonAdapter
    def initialize(api_key:, debug: false)
      @gibbon = Gibbon::Request.new(api_key: api_key, debug: debug)
    end

    def all_lists
      gibbon.lists.retrieve
    rescue Gibbon::MailChimpError => err
      raise MailChimpAdapter::MailChimpError, err.message
    end

    def find_list(list_id)
      response = gibbon.lists(list_id).retrieve
    rescue Gibbon::MailChimpError => err
      raise MailChimpAdapter::MailChimpError, err.message
    end

    def add_member_to_list(list_id, email:, name: nil)
      gibbon.lists(list_id).members(Digest::MD5.hexdigest(email)).upsert(
        body: {
          email_address: email,
          status: 'subscribed'
        }
      )
    rescue Gibbon::MailChimpError => err
      raise MailChimpAdapter::MailChimpError, err.message
    end

    private

    attr_reader :gibbon
  end
end
