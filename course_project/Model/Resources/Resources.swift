import Foundation
import SwiftUI

enum Resources {
    
    enum LightTheme {
        
        static let blueColor = Color(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1.0))
        static let redColor = Color(UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0))
        static let greenColor = Color(UIColor(red: 0.2, green: 0.78, blue: 0.35, alpha: 1.0))
        static let grayColor = Color(UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1.0))
        static let grayLightColor = Color(UIColor(red: 0.82, green: 0.82, blue: 0.84, alpha: 1.0))
        static let whiteColor = Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        enum Label {
            static let blackColor = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
            static let secondaryColor = Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6))
            static let TetiaryColor = Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3))
            static let disableColor = Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15))
        }
        
        enum Support {
            static let separatorColor = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
            static let overlayColor = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.06))
            static let navBarBlurColor = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.06))
        }
        
        enum Back {
            static let iosPrimaryColor = Color(UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0))
            static let primaryColor = Color(UIColor(red: 0.97, green: 0.97, blue: 0.95, alpha: 1.0))
            static let secondaryColor = Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            static let elevantedColor = Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        }
        
        enum Buttons {
            static let arrowButton = "arrowButton"
        }
        
        enum Images {
            static let exclamationMark = "exclamationMark"
            static let darkCalendar = "darkCalendar"
            static let lightCalendar = "lightCalendar"
        }
    }
    
    enum DarkTheme {
        
        static let blueColor = Color(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1.0))
        static let redColor = Color(UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0))
        static let greenColor = Color(UIColor(red: 0.2, green: 0.78, blue: 0.35, alpha: 1.0))
        static let grayColor = Color(UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1.0))
        static let grayLightColor = Color(UIColor(red: 0.82, green: 0.82, blue: 0.84, alpha: 1.0))
        static let whiteColor = Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        enum Label {
            static let primaryColor = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1.0))
            static let secondaryColor = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6))
            static let TetiaryColor = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.4))
            static let disableColor = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.15))
        }
        
        enum Support {
            static let separatorColor = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.2))
            static let overlayColor = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.32))
            static let navBarBlurColor = Color(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9))
        }
        
        enum Back {
            static let iosPrimaryColor = Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            static let primaryColor = Color(UIColor(red: 0.09, green: 0.09, blue: 0.09, alpha: 1.0))
            static let secondaryColor = Color(UIColor(red: 0.14, green: 0.14, blue: 0.16, alpha: 1.0))
            static let elevantedColor = Color(UIColor(red: 0.23, green: 0.23, blue: 0.25, alpha: 1.0))
        }
        
        enum Buttons {
            static let arrowButton = "arrowButton"
        }
        
        enum Images {
            static let exclamationMark = "exclamationMark"
        }
    }
}
