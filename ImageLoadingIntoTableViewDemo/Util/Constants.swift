//
//  Constants.swift
//  ImageLoadingIntoTableViewDemo
//  Holder class for constant values used by the application
//  Created by James Lane on 11/13/21.
//

import Foundation
import UIKit

public enum UserServiceError : Error {
    case BadUrl
}

class Constants {

    // Users API URL + Hardcoded headers for page 1, order by description, and sort by reputation score
    public static let REQUEST_URL = "https://api.stackexchange.com/2.2/users?page=1&order=desc&sort=reputation&site=stackoverflow"
    
    // string labels
    public static let GOLD_BADGES = "Gold badges: "
    public static let SILVER_BADGES = "Silver badges: "
    public static let BRONZE_BADGES = "Bronze badges: "
    public static let MY_NAME = "James Lane"
    public static let HEADER_TITLE = "Wag Challenge"
    public static let ABOUT_ME_TEXT = "Working to build products that delight and improve peoples' lives."
    public static let DOWNLOAD_TITLE = "Loading Users"
    public static let DOWNLOAD_ERROR_TITLE = "Download Error"
    
    // Asset names
    public static let ABOUT_ME_IMAGE = "about_me_image"
    
    // Table cell reuse id
    public static let TableCellId = "UserTableCellView"
}

extension UIFont {
    public static let Font16Bold = UIFont.boldSystemFont(ofSize: 16.0)
    public static let Font24Bold = UIFont.boldSystemFont(ofSize: 24.0)
    public static let Font14Regular = UIFont.systemFont(ofSize: 14.0)
    
}

extension UIColor {
    public static let WagColor = UIColor(red: 22.0 / 255.0, green: 176 / 255.0, blue: 120 / 255.0, alpha: 1.0)
}
