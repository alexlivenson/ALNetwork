Pod::Spec.new do |spec|
  spec.name = "Network"
  spec.version = "1.0.0"
  spec.summary = "Framework used for networking in my projects."
  spec.homepage = "https://github.com/alexlivenson/Network"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Alex Livenson" => 'alexlivenson@gmail.com' }

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/alexlivenson/Network.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "Network/**/*.{h,swift}"

  spec.dependency "Alamofire", "~> 4.4.0"
  spec.dependency "RxSwift", "~> 3.5.0" 
end
