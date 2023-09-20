class ParamParser
  FORMATS = { "year" => '%Y',
    "month" => '%m',
    "day" => '%d', 
    "hour" => '%k',
    "minute" => '%M', 
    "second" => '%S'}

  def initialize(params)
    @params = params
    @format_string = ""
    @invalid_formats = [] 
  end 

  Response = Struct.new(:success?, :format_string, :invalid_formats)

  def call 
    result = @params.all? {|s| FORMATS.key? s}
    @params.each do |f|  
      @format_string += "#{ParamParser::FORMATS[f]}" + "-"
      @invalid_formats << f if ParamParser::FORMATS[f].nil? 
    end 
    
    Response.new(result, @format_string, @invalid_formats)
  end 
end
