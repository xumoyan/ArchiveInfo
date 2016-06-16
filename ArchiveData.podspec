Pod::Spec.new do |s|
  s.name         = "ArchiveData"
  s.version      = "0.0.1"
  s.summary      = "save some information."
  s.homepage     = "https://github.com/xumoyan/ArchiveInfo"
  s.license      = "MIT"
  s.author       = { "xumoyan" => "13391572563@163.com" }
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/xumoyan/ArchiveInfo.git", :tag => s.version.to_s }
  s.source_files  = 'ArchiveData/*'
end
