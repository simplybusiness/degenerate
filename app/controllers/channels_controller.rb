class ChannelsController < ApplicationController
  def view
    @channel_name = params[:name]
  end
end
