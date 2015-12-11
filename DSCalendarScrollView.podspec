Pod::Spec.new do |s|
s.name             = "DSCalendarScrollView"
s.version          = "0.1.1"
s.summary          = "DSCalendarScrollView used to create Dynamic Calendar View on Scroll view ."
s.homepage         = "https://github.com/gitdotsquares/DSCalendarScrollView"
s.license          = { :type => 'MIT', :file => '../LICENSE' }
s.author           = { "Sumit Shastri" => "sumit.kumar@dotsquares.com" }
s.source           = { :git => "https://github.com/gitdotsquares/DSCalendarScrollView.git", :tag => s.version.to_s }
s.platform     = :ios, '7.0'
s.requires_arc = true
s.source_files = 'DSCalendarScrollView/*'
end