module ApiModule

  def self.admin_api_post_call(url, params)
    begin
      resource = RestClient::Resource.new(url,:timeout => 25, :open_timeout => 5)
      response = resource.post params, :content_type => 'application/json'
      error = false
    rescue RestClient::ExceptionWithResponse => err
      Rails.logger.debug "RestClient POST call failed\n #{err.response}"
      response = err.response
    end

    if response && response.exclude?("xml")
      return yield response if block_given?
    end
    response
  end

  def self.admin_api_get_call(url, params, access_key=nil)
    begin
      resource = RestClient::Resource.new(url,:timeout => 100, :open_timeout => 5)
      if access_key==nil
        response = resource.get params: params , :content_type => 'application/json'
      else
        response = resource.get params: params , :content_type => 'application/json', :Authorization=>'Token BPehDhjfmMaomcn2ZbnWuyaqRzrZoTS1ezAMlZs1'
      end  
    rescue RestClient::ExceptionWithResponse => err
      Rails.logger.debug "RestClient GET call failed\n #{err.response}"
      response = err.response
    end

    if response && response.exclude?("xml")
      return yield response if block_given?
    end
    response
  end
end