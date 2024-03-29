Pod::Spec.new do |s|
s.name         = "LYSCommonWKWebKit"
s.version      = "0.0.2"
s.summary      = "使用WKWebView解决开发中,H5与原生混合过程中,js和原生交互繁琐,逻辑复杂,频繁交换数据的问题"
s.description  = <<-DESC
解决开发中,H5与原生混合过程中,js和原生交互繁琐,逻辑复杂,频繁交换数据的问题
可以快速给window绑定事件,传递参数.获取数据
DESC
s.homepage     = "https://github.com/LIYANGSHUAI/LYSCommonWKWebKit"
s.platform       = :ios
s.license      = "MIT"
s.author             = { "LIYANGSHUAI" => "liyangshuai163@163.com" }
s.source       = { :git => "https://github.com/LIYANGSHUAI/LYSCommonWKWebKit.git", :tag => "0.0.2" }
s.source_files  = "LYSCommonWKWebKit/*.{h,m}"
end
