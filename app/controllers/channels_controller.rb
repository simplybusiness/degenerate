require "slack"

class ChannelsController < ApplicationController
  def view
    @channel_name = params[:name]
    channel = Slack.channels_join(name: @channel_name)["channel"]

    config = Rails.configuration.degenerate["slack"]
    user = config["username"]
    messages = Slack.channels_history(channel: channel["id"],
                                      count: 50)
    @messages = messages["messages"]
  end

  def post_message
    channel_name = params[:name]
    text = params[:text]
    channel = Slack.channels_join(name: channel_name)["channel"]
    config = Rails.configuration.degenerate["slack"]

    Slack.chat_postMessage(channel: channel["id"],
                           text: text,
                           username: config["username"],
                           link_names: 1)
    redirect_to action: :view
  end

end
