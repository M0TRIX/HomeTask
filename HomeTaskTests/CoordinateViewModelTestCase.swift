//
//  CoordinateViewModelTestCase.swift
//  HomeTaskTests
//
//  Created by WebVajhegan on 3/8/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

@testable import HomeTask
import XCTest
import CoreLocation

class CoordinateViewModelTestCase: XCTestCase {
    
    var coordinateViewModel: CoordinateViewModel?
    var coordinatesViewModel: [CoordinateViewModel]?
    var coordinates: [Coordinate]?
    
    override func setUp() {
        super.setUp()
        coordinateViewModel = CoordinateViewModel()
        coordinatesViewModel = [CoordinateViewModel]()
        coordinates = [Coordinate]()
        testAddCustomAnnotaion()
        testDrawpolyLine()
        testGetListOfPoints()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddCustomAnnotaion(){
        
        coordinates?.append(Coordinate(location: CLLocation(latitude: 37.33423373180452, longitude: -122.02658374534485), title: "Sccoter 1"))
        coordinates?.append(Coordinate(location: CLLocation(latitude: 37.33326976575647, longitude: -122.03216274036747), title: "Sccoter 2"))
        coordinates?.append(Coordinate(location: CLLocation(latitude: 37.32963558780564, longitude: -122.0288582587603), title: "Sccoter 3"))
        coordinates?.append(Coordinate(location: CLLocation(latitude: 37.33146976060335, longitude: -122.02764590022653), title: "Sccoter 4"))
        coordinates?.append(Coordinate(location: CLLocation(latitude: 37.33261289682598, longitude: -122.02783901923642), title: "Sccoter 5"))
        
        for object in coordinates! {
            self.coordinatesViewModel?.append(CoordinateViewModel(coordinate: object, context: BaseViewController()))
        }
        
        coordinateViewModel?.addCustomAnnotation(coordinatesViewModel: coordinatesViewModel!, completion: { (customAnnotaion) in
            XCTAssertNotNil(customAnnotaion)
        })
    }
    
    func testDrawpolyLine(){
        let location = CLLocation(latitude: 37.33423373180452, longitude: -122.02658374534485)
        let closest = CLLocation(latitude: 37.33261289682598, longitude: -122.02783901923642)
        coordinateViewModel?.drawpolyLine(oregin: location, closest: closest, completion: { (rect, route) in
            XCTAssertNotNil(rect)
            XCTAssertNotNil(route)
            XCTAssertGreaterThan(route.steps.count, 1)
        })
    }
    
    func testGetListOfPoints(){
        coordinateViewModel?.getListOfPoints(completion: { (data) in
            XCTAssertNotNil(data)
        })
    }
}
