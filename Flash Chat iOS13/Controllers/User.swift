//
//  User.swift
//  Flash Chat iOS13
//
//  Created by Osama El Hussiny on 4/20/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation


struct User : Encodable{
    let userId : String
    let userName : String
    let fullName : String
    let jobTitle : String
    let bio : String
}
