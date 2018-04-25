Pod::Spec.new do |s|
  s.name = 'SFDesignables'
  s.version = '0.1.0'
  s.summary = 'A collection of iOS @designable classes'
  s.description = <<-DESC
Subclasses of UIView, UIButton and UITextField with support for direct storyboard configurations.
                  DESC
  s.homepage = 'https://github.com/sudofluff/sfdesignables'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Sudofluff' => 'jinhedev@gmail.com' }
  s.source = { :git => 'https://github.com/sudofluff/SFDesignables.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.3'
  s.source_files = ['sfdesignables/*']
end
