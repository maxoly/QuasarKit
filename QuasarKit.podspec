#
# Be sure to run `pod lib lint QuasarKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "QuasarKit"
  s.version          = "0.1.0"
  s.summary          = "QuasarKit is a lightweight framework to executing actions every so often."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                         A fully thread-safe framework that will only execute an action (aka a block) passed for a given name if the last time it was called is greater than a limit or it has never been called. It also support previous action cancellation.
                       DESC

  s.homepage         = "https://github.com/maxoly/QuasarKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Massimo Oliviero" => "massimo.oliviero@gmail.com" }
  s.source           = { :git => "https://github.com/maxoly/QuasarKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/maxoly'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'QuasarKit/QuasarKit/**/*'
  s.frameworks = 'Foundation'
  
end
