//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift
import OAuthSwiftAlamofire
import KeychainAccess

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var tagline: String?
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["tagline"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
    }
}
