//
//  Structs.swift
//  Codable
//
//  Created by Eli Slade on 2017-06-08.
//  Copyright © 2017 Eli Slade. All rights reserved.
//

import Foundation

struct Post: APIListable {
    static let endpoint = "/posts"
    
    let title:String
    let body:String
}

struct User: APIListable {
    static var endpoint = "/users"
    
    let id:Int
    let name:String
    let username:String
}
