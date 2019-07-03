//
//  Delivery.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 02/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import Foundation

struct Delivery: Codable {
    let id: Int?
    let description: String?
    let imageUrl: String?
    let location: LocationData?
    
    struct LocationData: Codable {
        let lat : Double?
        let lng : Double?
        let address : String?
    }

}


