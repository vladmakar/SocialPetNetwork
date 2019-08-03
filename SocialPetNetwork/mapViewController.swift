//
//  mapViewController.swift
//  SocialPetNetwork
//
//  Created by Влад Макар on 2019-08-03.
//  Copyright © 2019 Влад Макар. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class mapViewController : UIViewController, CLLocationManagerDelegate
{
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var sosButton: UIButton!
    @IBOutlet weak var lostPetsButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        if(CLLocationManager.locationServicesEnabled() == true) {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            print("PLease turn on location services or GPS " )
        }
    }
    
    //MARK : CLLocationManager Delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        self.locationManager.stopUpdatingLocation()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Unable to access your location" )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


