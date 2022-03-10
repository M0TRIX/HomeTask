//
//  BaseViewController.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/4/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import UIKit
import MapKit

class BaseViewController: UIViewController {
    
    var locationManager: CLLocationManager!
    var reachability = Reachability()!
    var IsConnected:Bool?
    
    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var loading:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerWidgets()
        setListeners()
    }
    
    func registerWidgets(){
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                self.IsConnected = true
                self.loadOnline()
                
            } else {
                self.IsConnected = true
                self.loadOnline()
            }
        }
        reachability.whenUnreachable = { _ in
            self.IsConnected = false
            self.loadOffline()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            self.IsConnected = false
        }
    }
    
    func setListeners(){
    }
    
    func loadOnline(){
    }
    
    func loadOffline(){
        MessageUtill.makeMessage(title: "No connection", body: "check your internet connection",warningTitle:"retry", controller: self) {
            if self.IsConnected == false {
                self.loadOffline()
            }
        }
    }
}

extension BaseViewController:CLLocationManagerDelegate{
    func locationManagerSetup(){
        DispatchQueue.main.async {
            
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager.delegate = self
                self.locationManager.distanceFilter = kCLDistanceFilterNone
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                if #available(iOS 8.0, *) {
                    self.locationManager.requestAlwaysAuthorization()
                }
                self.locationManager.allowsBackgroundLocationUpdates = true
                self.locationManager.startUpdatingLocation()
            }else{
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
            }
            
        }
        
    }
}
