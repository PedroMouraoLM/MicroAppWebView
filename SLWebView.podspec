Pod::Spec.new do |s|
  s.name             = "SLWebView"
  s.version          = "1.0"
  s.summary          = "SLWebView is a delightful, lightweight Swift wrapper around UIWebView that lets you harness the power of Closures and Chaining. "

  s.description      = <<-DESC
                      SLWebView is a delightful, lightweight Swift wrapper around UIWebView that lets you harness the power of Closures and Chaining. 
                      And of course - Get rid of those pesky, awful delegates ;-) 
                       DESC

  s.homepage         = "https://github.com/freak4pc/SLWebView"
  s.license          = 'MIT'
  s.author           = { "freak4pc" => "pedro.mourao@soluevo.com.br" }
  s.source           = { :git => "https://github.com/PedroMouraoLM/MicroAppWebView.git", :tag => s.version }
  s.social_media_url = ''

  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.source_files     = '*.swift'
end