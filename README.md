# kakao-rest-api - Simple Kakao platform REST API client for Ruby
[![Gem Downloads](https://img.shields.io/gem/dt/rails.svg)](https://rubygems.org/gems/kakao-rest-api)
[![Gem Version](https://badge.fury.io/rb/gem-release.png)](https://rubygems.org/gems/kakao-rest-api)

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

## token refresh
client.refresh_token(refresh_token)

...
```

문서는 계속 업데이트될 예정입니다. 

