//
//  User.swift
//  ImageLoadingIntoTableViewDemo
//  User object returned from array of users from StackOverlfow Users REST API
//  Created by James Lane on 11/13/21.
//

import Foundation

public struct User : Codable {
    
    //MARK: JSON properties
    
    var accountId : Int
    var badgeCounts : BadgeCounts
    var gravatarImageUrl : String
    var isEmployee : Bool
    var location : String?
    var profileUrl : String
    var username : String
    
    
    //MARK: Deserialization
    
    enum CodingKeys : String, CodingKey {
        
        case accountId = "account_id"
        case badgeCounts = "badge_counts"
        case gravatarImageUrl = "profile_image"
        case isEmployee = "is_employee"
        case location = "location"
        case profileUrl = "link"
        case username = "display_name"
        
    }
}
