Pod::Spec.new do |s|
	s.name             = "VectorKit"
	s.version          = "0.1.0"
	s.summary          = "Powerful vector operations for the types you're already using."

  s.description      = <<-DESC
		VectorKit gives you powerful vector operations for the types you're already using, by providing a Vector
		protocol which can give any type the power to perform vector operations.
                       DESC

	s.homepage         = "https://github.com/davidisaaclee/VectorKit"
	s.license          = 'MIT'
	s.author           = { "David Lee" => "david.isaac.lee@gmail.com" }
	s.source           = { :git => "https://github.com/davidisaaclee/VectorKit.git", :tag => s.version.to_s }
	s.social_media_url = 'https://twitter.com/davidisaaclee'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'VectorKit' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
