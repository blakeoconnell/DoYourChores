//
//  MapViewController.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 11/16/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var address = ""
    
    var coords: CLLocationCoordinate2D?

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLGeocoder().geocodeAddressString(address, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    //let placemark = placemarks![0]
                    //let location = placemark.location
                    
                    //let place = MKPlacemark(placemark: placemark)
                    
                   // let mapItem = MKMapItem(placemark: place)
                    
                   // let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    
                    //mapItem.openInMaps(launchOptions: options)

                }
        
        
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
