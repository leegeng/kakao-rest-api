class Talk
  HOST_KAUTH = 'https://kauth.kakao.com'
  HOST_KAPI = 'https://kapi.kakao.com'

  def self.talk_profile(access_token, secure_resource = false)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/talk/profile"
    RestClient.get(request_url, Authorization: authorization)
  end
end
