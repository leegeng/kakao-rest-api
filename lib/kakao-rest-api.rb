require 'rest-client'
require 'v1/user'
require 'v1/api/story'
require 'v1/api/talk'

class KakaoRestApi
  attr_accessor :app_key, :admin_key, :authorize_code, :redirect_uri

  HOST_KAUTH = 'https://kauth.kakao.com'
  HOST_KAPI = 'https://kapi.kakao.com'

  def initialize(app_key, admin_key, redirect_uri)
    self.app_key = app_key
    self.admin_key = admin_key
    self.redirect_uri = redirect_uri
  end

  def set_authorize_code(authorize_code)
    self.authorize_code = authorize_code
  end

  def login(state = nil, encode_state = false)
    response_type = 'code'
    path = "/oauth/authorize?client_id=#{app_key}&redirect_uri=#{redirect_uri}&response_type=#{response_type}"

    unless state.nil?
      path.concat("&state=#{state}")
    end

    if encode_state
      path.concat('&encode_state=true')
    end

    "#{HOST_KAUTH}#{path}"
  end

  def token
    query_params = {
      grant_type: 'authorization_code',
      client_id: app_key,
      redirect_uri: redirect_uri,
      code: authorize_code
    }
    
    request_url = "#{HOST_KAUTH}/oauth/token"
    RestClient.post(request_url, query_params)
  end

  def refresh_token(refresh_token)
    query_params = {
      grant_type: 'refresh_token',
      client_id: app_key,
      refresh_token: refresh_token
    }

    request_url = "#{HOST_KAUTH}/oauth/token"
    RestClient.post(request_url, query_params)
  end

  def logout(access_token)
    User.logout access_token
  end

  def signup(access_token, properties = {})
    User.signup access_token, properties
  end

  def unlink(access_token)
    User.unlink access_token
  end

  def me(access_token, property_keys = [], secure_resource = false)
    User.me access_token, property_keys, secure_resource
  end

  def update_profile(access_token, props = {})
    User.update_profile access_token, props
  end

  def user_ids(limit = 100, from_id = 0, order = 'asc')
    User.ids admin_key, limit, from_id, order
  end

  def access_token_info(access_token)
    User.access_token_info access_token
  end

  def is_story_user?(access_token)
    Story.is_story_user? access_token
  end

  def story_profile(access_token, secure_resource = false)
    Story.story_profile access_token, secure_resource
  end

  def story_post(access_token, type, required_params, options = {})
    required_params[:access_token] = access_token

    case type
    when Story::POST_TYPE_NOTE
      Story.post_note required_params, options
    when Story::POST_TYPE_IMAGE
      file_paths = required_params[:image_url_list]
      required_params[:image_url_list] = upload_multi(access_token, file_paths)
      Story.post_photo required_params, options
    when Story::POST_TYPE_LINK
      url = required_params[:url]
      required_params[:link_info] = link_info(access_token, url)
      Story.post_link required_params, options
    end
  end

  def my_story(access_token, story_id)
    Story.my_story access_token, story_id
  end

  def my_stories(access_token, last_id)
    Story.my_stories access_token, last_id
  end

  def delete_my_story(access_token, id)
    Story.delete_my_story access_token, id
  end

  def talk_profile(access_token, secure_resource = false)
    Talk.talk_profile access_token, secure_resource
  end

  def upload_multi(access_token, file_paths)
    files = []
    file_paths.each do |path|
      files << File.new(path, 'rb')
    end

    Story.upload_multi access_token, files
  end

  def link_info(access_token, url)
    Story.link_info access_token, url
  end
end
