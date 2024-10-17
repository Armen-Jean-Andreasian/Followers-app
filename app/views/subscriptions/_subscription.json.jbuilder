json.extract! subscription, :id, :user_id, :follows_id, :follows_type, :followers_id, :followers_type, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
