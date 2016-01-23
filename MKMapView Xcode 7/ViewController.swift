//
//  ViewController.swift
//  MKMapView Xcode 7
//
//  Created by PJ Vea on 7/25/15.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        */
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        }
        
        
        /*
        // Show artwork on map
        let artwork = Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        mapView.addAnnotation(artwork)
        */
        
    }
    
    
    @IBAction func requestLocation(sender: AnyObject) {
        
        locationManager.requestLocation()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
        
        // let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        print("Latitude: \(location!.coordinate.latitude), Longtitude: \(location!.coordinate.longitude)")
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        let latitude = center.latitude
        let longtitude = center.longitude
        
        
        // self.mapView.setRegion(region, animated: true)
        
        self.mapView.setRegion(coordinateRegion, animated: true)
        
        // self.locationManager.stopUpdatingLocation()
        
        /*
        // Show artwork on map
        let artwork = Artwork(title: "Current Location", locationName: "BYU-Idaho Smith Building", discipline: "Education", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longtitude))
        
        mapView.addAnnotation(artwork)
        */
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription)
    }
    
}

