require 'rest-client'

class KakaoRestApi
  attr_accessor :app_key, :admin_key, :authorize_code, :redirect_uri

  STORY_POST_TYPE_NOTE = 0
  STORY_POST_TYPE_IMAGE = 1
  STORY_POST_TYPE_LINK = 2

  def initialize(app_key, admin_key, redirect_uri)
    # raise ArgumentError 'required parameter is blank' if app_key.blank? || admin_key.blank?
    self.app_key = app_key
    self.admin_key = admin_key
    self.redirect_uri = redirect_uri
  end

  def set_authorize_code(authorize_code)
    self.authorize_code = authorize_code
  end

  def login(state=nil, encode_state=nil)
    # raise ArgumentError 'required parameter is blank' if redirect_uri.blank?
    response_type = 'code'
    host = 'https://kauth.kakao.com'
    path = "/oauth/authorize?client_id=#{app_key}&redirect_uri=#{redirect_uri}&response_type=#{response_type}"

    "#{host}#{path}"
  end

  def token
    query_params = {
      grant_type: 'authorization_code',
      client_id: app_key,
      redirect_uri: redirect_uri,
      code: authorize_code
    }
    
    request_url = 'https://kauth.kakao.com/oauth/token'
    RestClient.post(request_url, query_params)
  end

  def refresh_token(refresh_token)
    query_params = {
      grant_type: 'refresh_token',
      client_id: app_key,
      refresh_token: refresh_token
    }

    request_url = 'https://kauth.kakao.com/oauth/token'
    RestClient.post(request_url, query_params)
  end

  def logout(access_token)
    authorization = "Bearer #{access_token}"

    request_url = 'https://kapi.kakao.com/v1/user/logout'
    RestClient.post(request_url, nil, Authorization: authorization)
  end

  def signup(access_token, properties = {})
    authorization = "Bearer #{access_token}"

    query_params = {
      properties: properties.to_json
    }

    request_url = 'https://kapi.kakao.com/v1/user/signup'
    RestClient.post(request_url, query_params, Authorization: authorization)
  end

  def unlink(access_token)
    authorization = "Bearer #{access_token}"

    request_url = 'https://kapi.kakao.com/v1/user/unlink'
    RestClient.post(request_url, nil, Authorization: authorization)
  end

  def me(access_token, property_keys = [], secure_resource = false)
    authorization = "Bearer #{access_token}"

    request_url = 'https://kapi.kakao.com/v1/user/me'
    RestClient.post(request_url, nil, Authorization: authorization)
  end

  def update_profile(access_token, props = {})
    authorization = "Bearer #{access_token}"
    params = {
      properties: props.to_json
    }
    request_url = 'https://kapi.kakao.com/v1/user/update_profile'
    RestClient.post(request_url, params, Authorization: authorization)
  end

  def user_ids(limit = 100, from_id = 0, order = 'asc')
    authorization = "KakaoAK #{admin_key}"
    params = {}
    params[:limit] = limit
    params[:from_id] = from_id if from_id > 0
    params[:order] = order

    request_url = 'https://kapi.kakao.com/v1/user/ids'
    RestClient.post(request_url, params, Authorization: authorization)
  end

  def access_token_info(access_token)
    authorization = "Bearer #{access_token}"

    request_url = 'https://kapi.kakao.com/v1/user/access_token_info'
    RestClient.get(request_url, Authorization: authorization)
  end

  def is_story_user?(access_token)
    authorization = "Bearer #{access_token}"

    request_url = 'https://kapi.kakao.com/v1/api/story/isstoryuser'
    RestClient.get(request_url, Authorization: authorization)
  end

  def story_profile(access_token, secure_resource = false)
    authorization = "Bearer #{access_token}"

    request_url = 'https://kapi.kakao.com/v1/api/story/profile'
    RestClient.get(request_url, Authorization: authorization)
  end

  def story_write_post(access_token, type, required_params, options = {})
    required_params[:access_token] = access_token

    case type
    when STORY_POST_TYPE_NOTE
      story_write_note_post required_params, options
    when STORY_POST_TYPE_IMAGE

    when STORY_POST_TYPE_LINK

    end
  end

  def self.default_story_post_options
    # TODO. add app schemes
    {
      permission: 'A',
      enable_share: false,
    }
  end

  def upload_multi(access_token, file_paths)
    authorization = "Bearer #{access_token}"
    content_type = 'multipart/form-data; boundary=---------------------------012345678901234567890123456'

    files = []
    file_paths.each do |path|
      files << File.new(path, 'rb')
    end

    params = {
      file: files,
      multipart: true
    }
    request_url = 'https://kapi.kakao.com/v1/api/story/upload/multi'
    RestClient.post(request_url, params, Authorization: authorization, content_type: content_type)
  end

  private

  def story_write_note_post(required_params, options)
    content = required_params[:content]
    access_token = required_params[:access_token]
    authorization = "Bearer #{access_token}"

    params = {}
    params[:content] = content
    params.merge!(options)

    request_url = 'https://kapi.kakao.com/v1/api/story/post/note'
    RestClient.post(request_url, params, Authorization: authorization)
  end
end
