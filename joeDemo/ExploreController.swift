//
//  ExploreController.swift
//  joeDemo
//
//  Created by Naman Sharma on 11/5/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import GoogleMaps

class ExploreController : UIViewController{
    var ref: DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewWillAppear(_ animated: Bool){
        //Load Name
        ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let usersRef = self.ref.child("users").child(userID);
        
     
        //Loads All Users To Map
        let allUsers = self.ref.child("users")
        allUsers.observeSingleEvent(of: .value, with: { (allUserSnap) in
            
            //setup MapView (set camera to your location)
            let camera = GMSCameraPosition.camera(withLatitude: 49.18683, longitude: -122.84899, zoom: 10)
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            mapView.isMyLocationEnabled = true;
            
            for singleUser in allUserSnap.children.allObjects as! [DataSnapshot]{
               let value = singleUser.value as? NSDictionary
                let isOnline = value!["online"] as? String ?? ""
                if(isOnline == "online"){
                    let name = value?["name"] as? String ?? ""
                    let joeType = value?["joeType"] as? String ?? ""
                    let lat = value?["lat"] as? String ?? ""
                    let long = value?["long"] as? String ?? ""
                    let latNum:CLLocationDegrees? = CLLocationDegrees(lat)
                    let longNum:CLLocationDegrees? = CLLocationDegrees(long)
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(latNum!, longNum!)
                    marker.title = name + " the \(joeType)";
                    marker.snippet = "4.7 / 5 Stars"
                    marker.map = mapView;
         
                }
                self.view = mapView;
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load Name
        ref = Database.database().reference()
        
        //Loads All Users To Map
        
        let allUsers = self.ref.child("users")
        allUsers.observeSingleEvent(of: .value, with: { (allUserSnap) in
            
            //setup MapView (set camera to your location)
            let camera = GMSCameraPosition.camera(withLatitude: 49.18683, longitude: -122.84899, zoom: 10)
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            mapView.isMyLocationEnabled = true;
            
            for singleUser in allUserSnap.children.allObjects as! [DataSnapshot]{
                let value = singleUser.value as? NSDictionary
                let isOnline = value!["online"] as? String ?? ""
                if(isOnline == "online"){
                    let name = value?["name"] as? String ?? ""
                    let joeType = value?["joeType"] as? String ?? ""
                    let lat = value?["lat"] as? String ?? ""
                    let long = value?["long"] as? String ?? ""
                    let latNum:CLLocationDegrees? = CLLocationDegrees(lat)
                    let longNum:CLLocationDegrees? = CLLocationDegrees(long)
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(latNum!, longNum!)
                    marker.title = name + " the \(joeType)";
                    marker.snippet = "4.7 / 5 Stars"
                    marker.map = mapView;
                    
                }
                self.view = mapView;
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
