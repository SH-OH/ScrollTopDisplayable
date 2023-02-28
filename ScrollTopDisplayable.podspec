#
# Be sure to run `pod lib lint ScrollTopDisplayable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScrollTopDisplayable'
  s.version          = '1.0.1'
  s.summary          = 'A protocol-based feature that displays or hides the view at the top based on scrolling.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/SH-OH/ScrollTopDisplayable'
  s.screenshots     = 'https://user-images.githubusercontent.com/50817510/221955138-8a11ea3d-8bfb-42d1-b29c-4234018a1250.mp4'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SH-OH' => 'dhtkdgh429@gmail.com' }
  s.source           = { :git => 'https://github.com/SH-OH/ScrollTopDisplayable.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/**/*.swift'
  
  # s.resource_bundles = {
  #   'ScrollTopDisplayable' => ['ScrollTopDisplayable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
