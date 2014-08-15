Pod::Spec.new do |s|

  s.name         = "GHKit"
  s.version      = "1.0.7"
  s.summary      = "Objective-C categories and utilities"
  s.homepage     = "https://github.com/gabriel/gh-kit"
  s.license      = 'MIT'
  s.author       = { "Gabriel Handford" => "gabrielh@gmail.com" }
  s.source       = { :git => "https://github.com/gabriel/gh-kit.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.source_files = 'Classes', 'Classes/iOS'

end
