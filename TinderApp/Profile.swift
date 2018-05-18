//
//  Profile.swift
//  TinderApp
//
//  Created by Jae on 14/05/18.
//  Copyright © 2018 Jae. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Profile {
    
    var name: String
    var image: UIImage?
    var isWishlist: Bool?
    
    init(name: String, image: UIImage, isWishlist: Bool) {
        
        guard let name = name as? String else { os_log("Failed to initialize profile name", log: OSLog.default, type: OSLogType.debug)}
        guard let image = image as? UIImage else { os_log("Failed to initialize profile image", log: OSLog.default, type: OSLogType.debug)}
        guard let isWishlist = isWishlist as? Bool else { os_log("Failed to initialize profile wishlist", log: OSLog.default, type: OSLogType.debug)}
        
        self.name = name
        self.image = image
        self.isWishlist = isWishlist
    }
}
