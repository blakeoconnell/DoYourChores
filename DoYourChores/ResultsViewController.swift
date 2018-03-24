//
//  ResultsViewController.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 11/16/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import MapKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timer : Timer?
    var counter = 0
    var hiddenButton = false
    var address = ""
    
    @IBOutlet weak var sessionSaveButton: UIButton!
    var coords: CLLocationCoordinate2D?
    
    var choresSession: choreSession = choreSession()
    
    @IBOutlet weak var resultsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer();
        if (hiddenButton == true){
            hideButton()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSession(_ sender: Any) {
        //save to coredata
        
        if (sessionSaveButton.titleLabel?.text == "Session saved!") {
            //do nothing
        }
        
        else if (sessionSaveButton.titleLabel?.text == "Click to save session."){
            choresSession.saveSession(address: address)
        sessionSaveButton.setTitle("Session saved!", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ResultsViewController.count), userInfo: nil, repeats: true)
        }
        else {
            print("Segue performed")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "unwindToMenu" {
            if (sessionSaveButton.titleLabel?.text == "Click for main menu.") {
                print("Segue happening!")
                return true
            }
            else {
                print("Segue not happening")
                return false
            }
        }
        return true
    }
    
    @objc func count() {
        counter = counter + 1
        if (counter == 10) {
            timer?.invalidate()
            sessionSaveButton.setTitle("Click for main menu.", for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    //    @IBAction func loadTable(_ sender: Any) {
    //        visitedPlaces.reloadData()
    //    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choresSession.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //            cell!.textLabel?.text = usersData.users[indexPath.row].getName();
            cell.textLabel?.text = choresSession.users[indexPath.row].getName();
        cell.detailTextLabel?.text = choresSession.users[indexPath.row].getChores();
            //cell!.textLabel?.text = choresSession.fetchUserResults[indexPath.row].name;
            let cell_Image = choresSession.getImage(name: (cell.textLabel?.text)!)
            cell.imageView?.image = cell_Image
        
        
        return cell
    }

    func hideButton() {
        sessionSaveButton.isEnabled = false
        sessionSaveButton.isHidden = true
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//            let des = segue.destination as! MapViewController
//        
//            des.address = address
//        
//    
//        
//    }
    
    @IBAction func openMap(_ sender: Any) {
    
        _ = CLGeocoder()
        CLGeocoder().geocodeAddressString(address, completionHandler:
        {(placemarks, error) in
        
        if error != nil {
        print("Geocode failed: \(error!.localizedDescription)")
        } else if placemarks!.count > 0 {
        let placemark = placemarks![0]
        
        let place = MKPlacemark(placemark: placemark)
        
        let mapItem = MKMapItem(placemark: place)
        
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMaps(launchOptions: options)
        
        }
        
        
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for person in choresSession.users {
            person.clearChores()
        }
    // back button was pressed.  We know this is true because self is no longer
    // in the navigation stack.
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
