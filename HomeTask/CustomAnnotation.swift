//
//  Artwork.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/5/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(
        title: String?,coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate

        super.init()
    }
    
}
