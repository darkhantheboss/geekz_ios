
import Foundation
import UIKit
import BSColorUtils

struct Colors {
    static let radiumGray = UIColor.with(hex: "#ff6485")
    static let radiumPink = UIColor.with(hex: "#ffd9ff")
    static let radiumDarkGray = UIColor.with(hex: "#E0A955")
    static let radiumUnselected = UIColor.with(hex: "#ffb3c3")
    static let urlGreen = UIColor.with(hex: "#046D23")
}

struct SettingsKeys {
    static let firstRun = "firstRun"
    static let trackHistory = "trackHistory"
    static let adBlockEnabled = "adBlockEnabled"
    static let stringLiteralAdBlock = "stringLiteralAdBlock"
    static let adBlockPurchased = "purchasedAdBlock"
    static let needToShowAdBlockAlert = "needToShowAdBlockAlert"
}

enum HostFileNames: String {
    case adaway
    case blackHosts
    case malwareHosts
    case camelon
    case zeus
    case tracker
    case simpleAds
    case adServerHosts
    case ultimateAdBlock
    
    static let allValues: [HostFileNames] = [.adaway, .blackHosts, .malwareHosts, .camelon, .zeus, .tracker, .simpleAds, .adServerHosts, .ultimateAdBlock]
}

let isiPadUI = UI_USER_INTERFACE_IDIOM() == .pad
let isiPhone5 = UIScreen.main.bounds.height == 568

func logRealmError(error: Error) {
	print("## Realm Error: \(error.localizedDescription)")
}

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
