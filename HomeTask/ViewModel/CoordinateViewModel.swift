//
//  HomeTaskViewModel.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/6/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import CoreLocation
import UIKit
import Foundation
import MapKit

class CoordinateViewModel{
    
    var context:BaseViewController?
    
    var location:CLLocation?
    var closestVehcile:CLLocation?
    var distance: CLLocationDistance?
    var mRegion:MKCoordinateRegion?
    var route = MKRoute()
    var rect = MKMapRect()
    
    var title:String?
    var currentScooterTitle = ""
    
    init(coordinate:Coordinate,context:BaseViewController) {
        self.location = coordinate.location
        self.title = coordinate.title
        self.context = context
    }
    
    init(context:BaseViewController) {
        self.context = context
    }
    

    func addCustomAnnotation(coordinatesViewModel:[CoordinateViewModel],completion:@escaping([CustomAnnotation])->()) {
        var customAnnotation = [CustomAnnotation]()
        for object in coordinatesViewModel {
            let pin = CustomAnnotation(title: object.title, coordinate: CLLocationCoordinate2DMake(object.location!.coordinate.latitude, object.location!.coordinate.longitude))
             customAnnotation.append(pin)
        }
        completion(customAnnotation)
    }
    
    func setRegion(latitude:Double,longitude:Double){
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mRegion = MKCoordinateRegion(center: center , span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    
    func drawpolyLine(oregin:CLLocation,closest:CLLocation,completion:@escaping(MKMapRect,MKRoute)->()){
        
        let source = CLLocationCoordinate2D(latitude: oregin.coordinate.latitude, longitude: oregin.coordinate.longitude)
        let destination = CLLocationCoordinate2D(latitude: closest.coordinate.latitude, longitude: closest.coordinate.longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: source, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            completion(response.routes[0].polyline.boundingMapRect,response.routes[0])
        }
    }
    
    func locationInLocations(locations: [CoordinateViewModel],myLocation: CLLocation){
        
        var smallestDistance: CLLocationDistance?
        
        for location in locations {
            distance = location.location!.distance(from: myLocation)
            currentScooterTitle = location.title ?? ""
            if smallestDistance == nil || distance! < smallestDistance! {
                self.closestVehcile = location.location ?? CLLocation()
                smallestDistance = distance
            }
        }
    }
    
    func getListOfPoints(completion:@escaping(Data)->()){
        ServiceApi.shared.getListOfCoordinations { (response,data)  in
            let error = ServiceValidator.checkResposnse(response: response, data: data)
            completion(data)// remove this line of code
            if error == ServiceError.SUCCESS {
                completion(data)
            }else{
                MessageUtill.makeMessage(title: "network call error", body: "\(error)", controller: self.context ?? BaseViewController())
            }
        }
    }
} 
