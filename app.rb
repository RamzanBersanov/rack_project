class App 
  def call(env)
    [status, headers, body]
  end 

  def status
    200
  end 

  def headers
    { 'Content-Type' => 'text/plain'}
  end 

  def body 
    [""]
  end 
end 
