//
//  BadgeCounts.swift
//  ImageLoadingIntoTableViewDemo
//  Object model for 'Badge Counts" property of stackoverflow 'User' object
//  This info could be retrieved also as a Dictionary of type [String: Int]
//  Created by James Lane on 11/13/21.
//

import Foundation

public struct BadgeCounts : Codable {
    
    // MARK: JSON Properties
    
    var bronze : Int
    var silver : Int
    var gold : Int
}
