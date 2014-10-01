class ApiController < ApplicationController
  def get_news
    render json: {news_feed: news_feed}
  end

  def get_weather
    render json: {weather: weather}
  end

  def get_access_log
    render json: {access_log: access_log}
  end

end