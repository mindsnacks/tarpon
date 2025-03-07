# frozen_string_literal: true

module Tarpon
  module Request
    class Subscriber
      class Entitlement < Base
        def initialize(subscriber_path:, entitlement_identifier:, **opts)
          super(**opts)
          @subscriber_path = subscriber_path
          @entitlement_identifier = entitlement_identifier
        end

        def grant_promotional(start_time_ms: nil, end_time_ms: nil, &block)
          body = {
            start_time_ms: start_time_ms,
            end_time_ms: end_time_ms
          }

          perform(method: :post, path: "#{path}/promotional", key: :secret, body: body, &block)
        end

        def revoke_promotional(&block)
          perform(method: :post, path: "#{path}/revoke_promotionals", key: :secret, &block)
        end

        private

        def path
          "#{@subscriber_path}/entitlements/#{@entitlement_identifier}"
        end
      end
    end
  end
end
