class MailChimpAdapter
  class MailChimpError < StandardError
    def initialize(original_error)
      @original_error = original_error
    end

    delegate :title,
             :detail,
             :body,
             :raw_body,
             :status_code,
             :to_s,
             to: :original_error

    private

    attr_reader :original_error
    delegate :instance_variables_to_s, to: :original_error
  end
end
