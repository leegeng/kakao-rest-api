class Story
  STORY_POST_TYPE_NOTE = 0
  STORY_POST_TYPE_IMAGE = 1
  STORY_POST_TYPE_LINK = 2

  HOST_KAUTH = 'https://kauth.kakao.com'
  HOST_KAPI = 'https://kapi.kakao.com'

  def self.is_story_user?(access_token)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/story/isstoryuser"
    RestClient.get(request_url, Authorization: authorization)
  end

  def self.story_profile(access_token, secure_resource = false)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/story/profile"
    RestClient.get(request_url, Authorization: authorization)
  end

  def self.my_story(access_token, story_id)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/story/mystory?id=#{story_id}"
    RestClient.get(request_url, Authorization: authorization)
  end

  def self.my_stories(access_token, last_id)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/story/mystories?last_id=#{last_id}"
    RestClient.get(request_url, Authorization: authorization)
  end

  def self.delete_my_story(access_token, id)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/story/delete/mystory?id=#{id}"
    RestClient.delete(request_url, Authorization: authorization)
  end

  def self.default_story_post_options
    # TODO. add app schemes
    {
        permission: 'A',
        enable_share: false
    }
  end

  def self.link_info(access_token, url)
    authorization = "Bearer #{access_token}"

    request_url = "#{HOST_KAPI}/v1/api/story/linkinfo?url=#{url}"
    RestClient.get(request_url, Authorization: authorization)
  end

  def self.upload_multi(access_token, files)
    authorization = "Bearer #{access_token}"
    content_type = 'multipart/form-data; boundary=---------------------------012345678901234567890123456'

    params = {
        file: files,
        multipart: true
    }
    request_url = "#{HOST_KAPI}/v1/api/story/upload/multi"
    RestClient.post(request_url, params, Authorization: authorization, content_type: content_type)
  end

  def self.post_note(required_params, options)
    content = required_params[:content]
    access_token = required_params[:access_token]
    authorization = "Bearer #{access_token}"

    params = {}
    params[:content] = content
    params.merge!(options)

    request_url = "#{HOST_KAPI}/v1/api/story/post/note"
    RestClient.post(request_url, params, Authorization: authorization)
  end

  def self.post_photo(required_params, options)
    content = required_params[:content]
    image_url_list = required_params[:image_url_list]
    access_token = required_params[:access_token]
    authorization = "Bearer #{access_token}"

    params = {}
    params[:content] = content || ''
    params[:image_url_list] = image_url_list
    params.merge!(options)

    request_url = "#{HOST_KAPI}/v1/api/story/post/photo"
    RestClient.post(request_url, params, Authorization: authorization)
  end

  def self.post_link(required_params, options)
    link_info = required_params[:link_info]
    content = required_params[:content]
    access_token = required_params[:access_token]
    authorization = "Bearer #{access_token}"

    params = {}
    params[:content] = content || ''
    params[:link_info] = link_info
    params.merge!(options)

    request_url = "#{HOST_KAPI}/v1/api/story/post/link"
    RestClient.post(request_url, params, Authorization: authorization)
  end
end
