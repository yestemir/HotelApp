//
//  Constants.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import Foundation
import UIKit

let baseUrl : String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/"
let hotelsExtensionURL : String = "0777.json"

struct Constants {
    
    static let star = UIImage(named: "star")
    static let starFilled = UIImage(named: "star_fill")
    static let bed = UIImage(named: "bed")
    static let location = UIImage(named: "location")
    static let noImage = UIImage(named: "no-photo")
    static let marker = UIImage(named: "marker")

    static let mainColor = UIColor(red: 63/255, green: 95/255, blue: 218/255, alpha: 1)
    static let mainColorForNav = UIColor(red: 39/255, green: 79/255, blue: 236/255, alpha: 1)
    static let white = UIColor(red: 241/255, green: 244/255, blue: 255/255, alpha: 1)
    static let orange = UIColor(red: 255/255, green: 153/255, blue: 58/255, alpha: 1)

}
