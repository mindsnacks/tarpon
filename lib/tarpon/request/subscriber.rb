# frozen_string_literal: true

module Tarpon
  module Request
    class Subscriber < Base
      def initialize(app_user_id:, **opts)
        super(**opts)
        @app_user_id = app_user_id
      end

      def get_or_create(&block)
        perform(method: :get, path: path, key: :public, &block)
      end

      def delete(&block)
        perform(method: :delete, path: path, key: :secret, &block)
      end

      def entitlements(entitlement_identifier)
        self.class::Entitlement.new(
          subscriber_path: path,
          entitlement_identifier: entitlement_identifier,
          client: @client
        )
      end

      def attributes
        self.class::Attribute.new(subscriber_path: path, client: @client)
      end

      def offerings
        self.class::Offering.new(subscriber_path: path, client: @client)
      end

      def subscriptions(product_id)
        self.class::Subscription.new(subscriber_path: path, product_id: product_id, client: @client)
      end

      private

      def path
        "/subscribers/#{@app_user_id}"
      end
    end
  end
end
