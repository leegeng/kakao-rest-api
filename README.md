# kakao_rest_api - Simple Kakao platform REST API client for Ruby
[![Gem Version](https://badge.fury.io/rb/kakao_rest_api.svg)](https://badge.fury.io/rb/kakao_rest_api)
[![Build Status](https://travis-ci.org/leegeng/kakao-rest-api.svg?branch=master)](https://travis-ci.org/leegeng/kakao-rest-api)
[![Gem](https://img.shields.io/gem/dt/kakao_rest_api.svg)](https://rubygems.org/gems/kakao_rest_api/)

## Overview
https://developers.kakao.com 의 REST API(https://developers.kakao.com/docs/restapi#간편한-참조-rest-api) 를 쉽게 사용하기 위한 Ruby Gem 입니다.
현재 상태는 푸쉬 토큰 관련 API를 제외한 기능을 제공하고 있습니다.

## Requirements 
rest-client 를 사용했기 때문에 최소 ruby 버전은 2.0.0 으로 해둡니다.

## Usage
각 API는 위 스펙 문서를 토대로 구성되어 있으며 required parameters 와 optional parameters 에 대한 정보는 여기(https://developers.kakao.com/docs/restapi#간편한-참조-rest-api)를 참조해주세요.

```ruby
require 'kakao_rest_api'

# initialize
client = KakaoRestApi.new(APP_KEY, ADMIN_KEY, REDIRECT_URI)

## login url 가져오기
client.login
=> "https://kauth.kakao.com/oauth/authorize?client_id=#{app_key}&redirect_uri=#{redirect_uri}&response_type=code"

## authorize_code 저장 
client.set_authorize_code(authorize_code)

## token 받기 
client.token
=> {
       "access_token":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
       "token_type":"bearer",
       "refresh_token":"yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy",
       "expires_in":43199,
       "scope":"Basic_Profile"
   }

## token refresh
client.refresh_token(refresh_token)
=> {
       "access_token":"wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww",
       "token_type":"bearer",
       "refresh_token":"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz",  //optional
       "expires_in":43199,
   }

## logout
client.logout(access_token)
=> {
       "id":123456789
   }
   
## signup
client.signup(access_token, properties)
=> {
       "id":123456789
   }

## unlink
client.unlink(access_token)
=> {
       "id":123456789
   }
   
## me
client.me(access_token, property_keys, secure_resource)
=> {
       "id":123456789,
       "properties":
       {
           "nickname":"홍길동",
           "thumbnail_image":"http://xxx.kakao.co.kr/.../aaa.jpg",
           "profile_image":"http://xxx.kakao.co.kr/.../bbb.jpg",
           "custom_field1":"23",
           "custom_field2":"여"
           ...
       }
   }
   
## update_profile
client.update_profile(access_token, properties)
=> {
       "id":123456789
   }
   
## user_ids
client.user_ids(limit, from_id, order)
=> {
     "elements": [
     1376016924426111111, 1376016924426222222, 1376016924426333333 ]
     , "total_count": 9
     , "before_url": "http://kapi.kakao.com/v1/user/ids?limit=3&order=desc&from_id=1376016924426111111&app_key=12345674ae6e12379d5921f4417b399e7"
     , "after_url": "http://kapi.kakao.com/v1/user/ids?limit=3&order=asc&from_id=1376016924426333333&app_key=12345674ae6e12379d5921f4417b399e7"
   }

## access_token_info
client.access_token_info(access_token)
=> {
       "id":123456789
       "expiresInMillis":239036
   }
   
## is_story_user
client.is_story_user?(access_token)
=> {
     "isStoryUser":true
   }

## story_profile
client.story_profile(access_token, secure_resource)
=> {
     "nickName":"홍길동",
     "profileImageURL":"http://xxx.kakao.com/.../aaa.jpeg",
     "thumbnailURL":"http://xxx.kakao.com/.../bbb.jpeg",
     "bgImageURL":"http://xxx.kakao.co.kr/.../ccc.jpg",
     "permalink": "https://story.kakao.com/XXXXX",
     "birthday":"1231",
     "birthdayType":"SOLAR"
   }

## story_post
### Note
required_params = {
  content: 'text'
}
client.story_post(access_token, Story::POST_TYPE_NOTE, required_params, optional_params)
=> {
       "id":"AAAAAAA.BBBBBBBBBBB"
   }

### Photo
required_params = {
  image_url_list: [FILE_PATH, FILE_PATH2]
}
client.story_post(access_token, Story::POST_TYPE_PHOTO, required_params, optional_params)
=> {
       "id":"AAAAAAA.BBBBBBBBBBB"
   }

### Link
required_params = {
  url: 'http://www.kakaocorp.com'
}
client.story_post(access_token, Story::POST_TYPE_LINK, required_params, optional_params)
=> {
       "id":"AAAAAAA.BBBBBBBBBBB"
   }

## my_story
client.my_story(access_token, story_id)
=> {
       "id": "AAAAAAA.CCCCCCCCCCC",
       "url": "http://story-web.kakao.com/AAAAAAA/CCCCCCCCCCC",
       "media_type": "PHOTO",
       "created_at": "2014-06-13T07:58:20Z",
       "comment_count": 1,
       "like_count": 1,
       "content": "This cafe is really awesome!",
       "media": [
           {
               "original":"http://xxx.kakao.co.kr/.../img.png?width=150&height=150",
               "xlarge":"http://xxx.kakao.co.kr/.../img_xl.jpg?width=150&height=150",
               "large":"http://xxx.kakao.co.kr/.../img_l.jpg?width=150&height=150",
               "medium":"http://xxx.kakao.co.kr/.../img_m.jpg?width=150&height=150",
               "small":"http://xxx.kakao.co.kr/.../img_s.jpg?width=150&height=150"
           }
       ],
         "comments": [
           {
             "text": "여기 위치가 어디?",
             "writer": {
               "display_name": "한여름",
               "profile_thumbnail_url": "http://xxxx.kakao.co.kr/.../ABCDEFG.jpeg"
             }
           }
         ],
         "likes": [
           {
             "emotion": "COOL",
             "actor": {
               "display_name": "여바다",
               "profile_thumbnail_url": "http://xxxx.kakao.co.kr/.../1234566.jpeg"
             }
           }
         ]
   }
   
## my_stories
client.my_stories(access_token, last_id)
=> [
       {
           "id": "AAAAAAA.BBBBBBBBBBB",
           "url": "http://story-web.kakao.com/AAAAAAA/BBBBBBBBBBB",
           "media_type": "NOT_SUPPORTED",
           "created_at": "2014-06-13T07:58:26Z",
           "comment_count": 3,
           "like_count": 4,
           "content": "better than expected!"
       },
       {
           "id": "AAAAAAA.CCCCCCCCCCC",
           "url": "http://story-web.kakao.com/AAAAAAA/CCCCCCCCCCC",
           "media_type": "PHOTO",
           "created_at": "2014-06-13T07:58:20Z",
           "comment_count": 1,
           "like_count": 1,
           "content": "This cafe is really awesome!",
           "media": [
               {
                   "original":"http://xxx.kakao.com/.../img.png?width=150&height=150",
                   "xlarge":"http://xxx.kakao.com/.../img_xl.jpg?width=150&height=150",
                   "large":"http://xxx.kakao.com/.../img_l.jpg?width=150&height=150",
                   "medium":"http://xxx.kakao.com/.../img_m.jpg?width=150&height=150",
                   "small":"http://xxx.kakao.com/.../img_s.jpg?width=150&height=150"
               }
           ]
       },
       {
           "id": "AAAAAAA.DDDDDDDDD",
           "url": "http://story-web.kakao.com/AAAAAAA/DDDDDDDDD",
           "media_type": "NOTE",
           "created_at": "2014-06-13T07:58:17Z",
           "comment_count": 0,
           "like_count": 10,
           "content": "A Rainbow - William Wordsworth\n\n..."
       },
       ...
   ]

## delete_my_story
client.delete_my_story(access_token, id)
=> ""

## talk_profile
client.talk_profile(access_token, secure_resource)
=> {
     "nickName":"홍길동",
     "profileImageURL":"http://xxx.kakao.co.kr/.../aaa.jpg",
     "thumbnailURL":"http://xxx.kakao.co.kr/.../bbb.jpg",
     "countryISO":"KR"
   }
```
