#
# Be sure to run `pod lib lint CHWPickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHWPickerView'
  s.version          = '0.2.0'
  s.summary          = 'An easy and useful Picker View'
  s.swift_version = '5'
  s.homepage         = 'https://github.com/chouheiwa/CHWPickerView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chouheiwa' => '849131492@qq.com' }
  s.source           = { :git => 'https://github.com/chouheiwa/CHWPickerView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'CHWPickerView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CHWPickerView' => ['CHWPickerView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
