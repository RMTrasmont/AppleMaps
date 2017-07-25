//
//  Restaurant.swift
//  MyMapKit
//
//  Created by Rafael M. Trasmontero on 5/12/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

import Foundation
import MapKit

class Restaurant: NSObject ,MKAnnotation {
    var identifier = "restaurant location"
    var title:String?
    var subtitle:String?
    var coordinate: CLLocationCoordinate2D
    
    var logoImageName:String?
    var webAddress:String?
    
    init(title:String?,subtitle:String?,coordinate:CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
    

}
