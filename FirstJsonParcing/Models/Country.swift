//
//  Country.swift
//  FirsJsonParcing
//
//  Created by Roman Dubovskoi on 4/4/25.
//

import Foundation


struct Country: Decodable {
    let code: String?
    let flag: String?
    let id: Int
    let name: String
}

struct Response: Decodable {
    let response: [Country]
}


