class User
  HOST_KAUTH = 'https://kauth.kakao.com'
  HOST_KAPI = 'https://kapi.kakao.com'

  def self.logout(access_token)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/user/logout"
    RestClient.post(request_url, nil, Authorization: authorization)
  end

  def self.signup(access_token, properties = {})
    authorization = "Bearer #{access_token}"

    query_params = {
      properties: properties.to_json
    }

    request_url = "#{HOST_KAPI}/v1/user/signup"
    RestClient.post(request_url, query_params, Authorization: authorization)
  end

  def self.unlink(access_token)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/user/unlink"
    RestClient.post(request_url, nil, Authorization: authorization)
  end

  def self.me(access_token, property_keys = [], secure_resource = false)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/user/me"
    RestClient.post(request_url, nil, Authorization: authorization)
  end

  def self.update_profile(access_token, props = {})
    authorization = "Bearer #{access_token}"
    params = {
      properties: props.to_json
    }
    request_url = "#{HOST_KAPI}/v1/user/update_profile"
    RestClient.post(request_url, params, Authorization: authorization)
  end

  def self.ids(admin_key, limit = 100, from_id = 0, order = 'asc')
    authorization = "KakaoAK #{admin_key}"
    params = {}
    params[:limit] = limit
    params[:from_id] = from_id if from_id > 0
    params[:order] = order

    request_url = "#{HOST_KAPI}/v1/user/ids"
    RestClient.post(request_url, params, Authorization: authorization)
  end

  def self.access_token_info(access_token)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/user/access_token_info"
    RestClient.get(request_url, Authorization: authorization)
  end
end