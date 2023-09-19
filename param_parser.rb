class ParamParser

  FORMATS = { "year" => '%Y',
    "month" => '%m',
    "day" => '%d', 
    "hour" => '%k',
    "minute" => '%M', 
    "second" => '%S'}

  def initialize(params)
    @params = params 
  end 

  def valid?
    @params.all? {|s| FORMATS.key? s}
  end 
end
