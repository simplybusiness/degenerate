require "slack"
Slack.configure do |slack|
  slack.token = Rails.configuration.degenerate["slack"]["token"]
  warn "slack token #{slack.token}"
end
