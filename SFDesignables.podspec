Pod::Spec.new do |s|
  s.name = 'SFDesignables'
  s.version = '0.1.1'
  s.summary = 'A collection of @IBdesignable classes for storyboarding.'
  s.homepage = 'https://github.com/sudofluff/SFDesignables'
  s.swift_version = '4.1.0'
  s.frameworks = 'UIKit'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'sudofluff' => 'sudofluff@icloud.com' }
  s.source = { :git => 'https://github.com/sudofluff/SFDesignables.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.3'
  s.source_files = 'Source/*.swift'
end
