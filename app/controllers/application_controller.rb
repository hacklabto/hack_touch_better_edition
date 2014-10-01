class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected


  def weather
    return @weather if @weather.present?
    w = Weather.new
    {
      current: w.now,
      today: w.today,
      tomorrow: w.tomorrow,
    }
    @weather = w
  end

  def news_items
    @news_items ||= NewsFeed.getAllArticles.first 5
  end

  def access_logs
    @access_logs ||= AccessLog.getRecent()
  end

end
