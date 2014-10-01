class WeatherCondition

  @forecast_keys = [:temp, :high, :low, :text, :code, :day]

  attr_accessor *@forecast_keys, :windspeed, :humidity

  def initialize(condition_or_forecast, wind = nil, atmosphere = nil)
    condition_or_forecast.symbolize_keys.slice(*@@forecast_keys).each do |k, v|
      send :"#{k}=", v
    end
    @is_forecast = wind.present?
    @windspeed   = wind['speed']
    @humidity    = atmosphere['humidity']
  end

  def code=(val)
    @code = val.to_i
  end

  def forecast?
    @is_forecast
  end

  def to_hash
    basics = {
      icon: icon,
      condition: text,
    }
    if forecast?
      details = {
        day: day,
        temp_high: high,
        temp_low: low,
      }
    else
      details = {
        temp: temp,
        windspeed: windspeed,
        humidity: humidity,
      }
    end
    basics.merge details
  end

  def icon
    self.class.icon_lookup[code] || "meow"
  end

  def self.icon_lookup
    @icon_lookup if @icon_lookup.present?
    # Populating the icon lookup from this hash. I'm not crazy. The world's
    # crazy! Your crazy! AHAHAHAHAHAAHAAHA!
    @icon_lookup = {}
    {
      heavy_storm: [0, 1, 2],
      heavy_storm_night: 3,
      heavy_storm_day: 4,
      rain_and_snow: [5,6,7],
      ice_rain: 8,
      rain_day: [9, 10],
      light_rain_day: 11,
      light_rain_night: 12,
      light_snow_day: [13, 14, 15],
      snow_day: 16,
      ice_rain: [17, 18],
      unknown: 19,
      heavy_fog_day: [20, 21, 22, 23],
      medium_clouds_day: 24,
      clear_day: 25,
      medium_clouds_day: 26,
      medium_heavy_clouds_night: 27,
      medium_heavy_clouds_day: 28,
      medium_clouds_night: 29,
      medium_clouds_day: 30,
      clear_night: [31, 33],
      clear_day: [32, 34],
      ice_rain: 35,
      clear_day: 36,
      heavy_storm_day: 37,
      rain_day: [38, 39],
      rain: 40,
      heavy_snow: 41,
      snow_day: 42,
      extra_heavy_snow: 43,
      medium_clouds_day: 44,
      rain: 45,
      snow_day: 46,
      rain: 47
    }.each do |icon, ids|
      # This is reasonable
      (ids.is_a?(Array) ? ids : [ids]).each {|id| @icon_lookup[id] = icon}
    end
    @icon_lookup
  end
end
