//
//  UserData.swift
//  ImageLoadingIntoTableViewDemo
//  Object model for response for the result of the StackOverflow Users API call
//  Created by James Lane on 11/13/21.
//

import Foundation

public struct UserData : Codable {
    
    //MARK: JSON Properties
    
    var users : [User]
    var hasMore : Bool
    var quotaMax : Int
    var quotaRemaining : Int
    
    //MARK: Deserialization
    
    enum CodingKeys : String, CodingKey {
        
        case users = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}
