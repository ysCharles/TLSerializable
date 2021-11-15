#
#  Be sure to run `pod spec lint TLSerializable.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TLSerializable"
  s.version      = "0.6"
  s.summary      = "基于 Codable 的 json 序列化和反序列化工具"


  s.homepage     = "https://github.com/ysCharles/TLSerializable"

  s.license      = "MIT"


  s.author             = { "Charles" => "ystanglei@gmail.com" }

  s.source       = { :git => "https://github.com/ysCharles/TLSerializable.git", :tag => "#{s.version.to_s}" }

  s.platform     = :ios, "11.0"



  s.source_files  = "Sources/TLSerializable/*.swift"

  s.swift_version = '5'

end
