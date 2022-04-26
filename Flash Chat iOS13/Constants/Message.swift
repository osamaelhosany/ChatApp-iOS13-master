//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by Osama El Hussiny on 4/19/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

struct Message : Codable {
    var senderId : String 
    let receiverId : String
    let sender : String
    let body : String
    let createdDate : String
    let timeStamp : String
}
