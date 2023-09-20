require_relative 'param_parser'

class App 
  def call(env)
    request = Rack::Request.new(env) 
    params = request.params["format"].split(',')

    result = ParamParser.new(params).call 

    if result.success?
      [200, {}, body = ["#{Time.new.strftime(result.format_string)}"]]
    else
      [400, {}, body = ["#{"Unknown time format #{result.invalid_formats}"}"]]
    end 
  end 
end
