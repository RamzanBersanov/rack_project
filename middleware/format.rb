require 'cgi'
require_relative 'params_error'
require_relative 'url_error'
class TimeFormat

  FORMATS = { "year" => '%Y',
    "month" => '%m',
    "day" => '%d', 
    "hour" => '%k',
    "minute" => '%M', 
    "second" => '%S'}

  def initialize(app)
    @app = app
  end 

  def call(env)
    status, headers, body = @app.call(env)
    begin
      raise UrlError.new if env["REQUEST_PATH"] != '/time'
      query_string_hash = CGI.parse(env["QUERY_STRING"])
      get_time_format_string(query_string_hash)
      raise ParamsError.new("Unknown time format #{@invalid_formats}") unless @invalid_formats.empty?
      body = ["#{Time.new.strftime(@format_string)}"]
    rescue UrlError => e
      status = 404
    rescue ParamsError => e 
      status = 400
      body = ["#{e.inspect}"] 
    end
    
    [status, headers, body]
  end 

  def get_time_format_string(query_string_hash)
    time_format = query_string_hash['format'] 
    time_format = time_format[0].split(',') 
    @format_string = ""
    @invalid_formats = []
    time_format.each do |f| 
      @format_string += "#{FORMATS[f]}" + "-"
      @invalid_formats << f if FORMATS[f].nil? 
    end 
  end
end 
