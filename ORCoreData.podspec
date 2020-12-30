#
# Be sure to run `pod lib lint ORCoreData.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ORCoreData'
  s.version          = '6.0.0'
  s.summary          = 'ORCoreData - components for work with CoreData'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'ORCoreDataSaver, ORCoreDataEntityFinderAndCreator & ORCoreDataRemover'
                       DESC

  s.homepage         = 'https://github.com/Omega-R/ORCoreData'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Maxim Soloviev" => "maxim@omega-r.com", 'Egor Lindberg' => 'egor.lindberg@omega-r.com' }
  s.source           = { :git => 'https://github.com/Omega-R/ORCoreData.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.swift_version = '5.0'

  s.source_files = 'Sources/ORCoreData/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ORCoreData' => ['ORCoreData/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency 'MagicalRecord', '~> 2.3'
end
