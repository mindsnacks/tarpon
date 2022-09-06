# frozen_string_literal: true

module Tarpon
  module Request
    class Receipt < Base
      def create(platform:, **data, &block)
        headers = { 'X-Platform' => platform }
        perform(method: :post, headers: headers, path: '/receipts', key: :public, body: data, &block)
      end
    end
  end
end
