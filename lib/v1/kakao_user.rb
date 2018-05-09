class KakaoUser
  HOST_KAUTH = 'https://kauth.kakao.com'.freeze
  HOST_KAPI = 'https://kapi.kakao.com'.freeze

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

  def self.me(access_token, property_keys = [], secure_resource = false, user_id = 0)
    authorization = "Bearer #{access_token}"
    params = {
      propertyKeys: property_keys,
      secure_resource: secure_resource
    }
    if user_id > 0
      params[:target_id_type] = 'user_id'
      params[:target_id] = user_id
    end

    request_url = "#{HOST_KAPI}/v1/user/me"
    RestClient.post(request_url, params, Authorization: authorization)
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
    params = { limit: limit, order: order }
    params[:from_id] = from_id if from_id.positive?
l
    request_url = "#{HOST_KAPI}/v1/user/ids?#{params.map { |k, v| "#{k}=#{v}" } * '&'}"
    RestClient.get(request_url, Authorization: authorization)
  end

  def self.access_token_info(access_token)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/user/access_token_info"
    RestClient.get(request_url, Authorization: authorization)
  end
end
