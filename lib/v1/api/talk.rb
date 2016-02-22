class Talk
  HOST_KAUTH = 'https://kauth.kakao.com'.freeze
  HOST_KAPI = 'https://kapi.kakao.com'.freeze

  def self.talk_profile(access_token, secure_resource = false)
    authorization = "Bearer #{access_token}"
    request_url = "#{HOST_KAPI}/v1/api/talk/profile"
    request_url.concat('&secure_resource=true') if secure_resource
    RestClient.get(request_url, Authorization: authorization)
  end
end
