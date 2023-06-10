suffix = '.0000'   # Dev mode
# suffix = ''       # Release

Pod::Spec.new do |s|
  
  s.name             = 'PlayKitGoogleCast'
  s.version          = '1.5.6' + suffix
  s.summary          = 'PlayKitGoogleCast -- Google cast framework for iOS'
  s.homepage         = 'https://github.com/joren-vos-aca/playkit-ios-googlecast'
  s.license          = { :type => 'AGPLv3', :file => 'LICENSE' }
  s.author           = { 'Kaltura' => 'community@kaltura.com' }
  s.source           = { :git => 'https://github.com/joren-vos-aca/playkit-ios-googlecast.git', :tag => 'v' + s.version.to_s }  
  s.source_files     = 'Sources/**/*'
  
  s.swift_version     = '5.0'
  s.static_framework = true

  s.ios.deployment_target = '12.0'

  s.dependency 'google-cast-sdk', '4.7.1'
end

