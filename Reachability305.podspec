#
#  Be sure to run `pod spec lint Reachability305.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

    spec.name         = "Reachability305"
    spec.version      = "0.0.2"
    spec.summary      = "Handles all changes in network connectivity and displays a message to the user accordingly. Simple Implementation + Customizable views"
    spec.description  = "Reachability305 is built on top of Apple's Reachability class. It handles all changes in network connectivity and displays a message to the user accordingly. The Reachability feature also supports custom views so you can display to the user any information you like."
    spec.license      = "MIT"
    spec.homepage     = "https://github.com/rjguzman42/Reachability305"
    spec.author       = { "Roberto Guzman" => "rjguzman42@gmail.com" }
    spec.platform     = :ios, "12.0"
    spec.swift_version = '5.0'
    spec.source       = { :git => "https://github.com/rjguzman42/Reachability305.git", :tag => "0.0.2" }
    spec.source_files  = "Reachability305"

end
