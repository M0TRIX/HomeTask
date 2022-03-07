//
//  ViewController.swift
//  HomeTask
//
//  Created by AliAsadi on 3/4/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HomeTaskViewController: BaseViewController{
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var directions: UIImageView!
    
    var coordinatesViewModel = [CoordinateViewModel]()
    var coordinates = [Coordinate]()
    var viewModel: CoordinateViewModel!
    
    var myLocation=CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CoordinateViewModel(context: self)
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    override func loadOnline() {
        super.loadOnline()
        self.getThePoints()
    }
    
    override func loadOffline() {
        super.loadOffline()
    }
    
    func getThePoints(){
        
        DispatchQueue.main.async {
            self.loading.isHidden = false
            self.loading.startAnimating()
        }
        
        viewModel.getListOfPoints { (data) in
            
            self.coordinates.append(Coordinate(location: CLLocation(latitude: 37.33423373180452, longitude: -122.02658374534485), title: "Sccoter 1"))
            self.coordinates.append(Coordinate(location: CLLocation(latitude: 37.33326976575647, longitude: -122.03216274036747), title: "Sccoter 2"))
            self.coordinates.append(Coordinate(location: CLLocation(latitude: 37.32963558780564, longitude: -122.0288582587603), title: "Sccoter 3"))
            self.coordinates.append(Coordinate(location: CLLocation(latitude: 37.33146976060335, longitude: -122.02764590022653), title: "Sccoter 4"))
            self.coordinates.append(Coordinate(location: CLLocation(latitude: 37.33261289682598, longitude: -122.02783901923642), title: "Sccoter 5"))
            
            for object in self.coordinates {
                self.coordinatesViewModel.append(CoordinateViewModel(coordinate: object, context: self))
            }
            
            DispatchQueue.main.async {
                self.loading.stopAnimating()
                self.loading.isHidden = true
                self.viewModel.addCustomAnnotation(coordinatesViewModel: self.coordinatesViewModel, completion: { pins in
                    self.mapView.addAnnotations(pins)
                    self.locationManagerSetup()
                })
            }
        }
    }
    
    override func setListeners() {
        super.setListeners()
        
        let uITapgetstureDirectionsAction = UITapGestureRecognizer(target: self, action: #selector(directionsAction))
        directions.isUserInteractionEnabled = true
        directions.addGestureRecognizer(uITapgetstureDirectionsAction)
    }
    
    @objc func directionsAction(){
        viewModel.drawpolyLine(oregin:myLocation,closest:viewModel.closestVehcile!, completion: ({rect,route in
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }))
    }
}

extension HomeTaskViewController:MKMapViewDelegate  {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        var annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "")
        
        if (mapView.userLocation.coordinate.latitude == annotation.coordinate.latitude && mapView.userLocation.coordinate.longitude == annotation.coordinate.longitude){
            return nil
        }else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom pin")
            annotationView.image =  UIImage(named: "scooter")
            annotationView.canShowCallout = true
            return annotationView
        }
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        MessageUtill.makeMessage(title: "rendering error", body: error.localizedDescription, controller: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        viewModel.setRegion(latitude: locValue.latitude, longitude: locValue.longitude)
        mapView.showsUserLocation = true
        mapView.setRegion(viewModel.mRegion ?? MKCoordinateRegion(), animated: true)
        self.myLocation = CLLocation(latitude: locValue.latitude ,longitude: locValue.longitude)
        
        viewModel.locationInLocations(locations: coordinatesViewModel, myLocation: self.myLocation)
        
        if viewModel.distance ?? 0  < 1000 {
            informationLabel.text = "\(viewModel.currentScooterTitle) : \(Int(viewModel.distance ?? 0)) M"
        }else{
            let distanceStr = String(format: "%.3f", (viewModel.distance ?? 1)/1000)
            informationLabel.text = "\(viewModel.currentScooterTitle ) : \(distanceStr) KM"
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay is MKPolyline) {
            let polyLine = MKPolylineRenderer(overlay: overlay)
            polyLine.strokeColor = UIColor.blue
            polyLine.fillColor = .green
            polyLine.lineWidth = 3
            return polyLine
        }else {
            return MKOverlayRenderer()
        }
    }
    
}

