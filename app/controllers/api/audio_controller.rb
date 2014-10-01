class AudioController < ApplicationController

  def streamlist
    render json: {}
  end

  def add_stream
    render :nothing
  end

  def now_playing
    render json: {}
  end

  def is_playing
    render json: {playing: true}
  end

  def play
    render :nothing
  end

  def stop
    render :nothing
  end

  def set_volume
    render :nothing
  end

end
