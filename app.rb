require 'cgi'
require_relative 'param_parser'

class App 
  def call(env)
    if env["REQUEST_PATH"] != '/time'
      [404, {}, ["#{Time.new}"]]
    else 
      @params = CGI.parse(env["QUERY_STRING"])['format'][0].split(',')
      result = ParamParser.new(@params)
      define_time_format

      if result.valid?
        [200, {}, body = ["#{Time.new.strftime(@format_string)}"]]
      else
        [400, {}, body = ["#{"Unknown time format #{@invalid_formats}"}"]]
      end 
    end 
  end 

  private 

  def define_time_format
    @format_string = ""
    @invalid_formats = []
    @params.each do |f|  
      @format_string += "#{ParamParser::FORMATS[f]}" + "-"
      @invalid_formats << f if ParamParser::FORMATS[f].nil? 
    end 
  end 
end
