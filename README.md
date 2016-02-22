# kakao-rest-api - Simple Kakao platform REST API client for Ruby
[![Gem Version](https://badge.fury.io/rb/kakao-rest-api.svg)](https://badge.fury.io/rb/kakao-rest-api)

## Overview
https://developers.kakao.com 의 REST API 를 쉽게 사용하기 위한 Ruby Gem 입니다.
현재 상태는 푸쉬 토큰 관련 API를 제외한 기능을 제공하며 약간 날림으로 만들어서 기본적인 기능만 확인됐고, 코드 리팩토링이 필요합니다. 

## Requirements 
rest-client 를 사용했기 때문에 최소 ruby 버전은 2.0.0 으로 해둡니다.

## Usage
```ruby
require 'kakao-rest-api'

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
   

```

문서는 계속 업데이트될 예정입니다. 

