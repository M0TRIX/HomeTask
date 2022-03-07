//
//  Coordinates.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/4/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import UIKit
import CoreLocation

struct Coordinate {
    let location:CLLocation?
    let title:String?
    
    init(location:CLLocation,title:String) {
        self.location = location
        self.title = title
    }
}
