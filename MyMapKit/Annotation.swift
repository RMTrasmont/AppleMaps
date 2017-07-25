//
//  Annotation.swift
//  MyMapKit
//
//  Created by Rafael M. Trasmontero on 5/10/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject ,MKAnnotation {
    var title:String?
    var subtitle:String?
    var coordinate: CLLocationCoordinate2D
    
    var imageName:String?
    
    init(title:String?,subtitle:String?,coordinate:CLLocationCoordinate2D){
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    
    }
    
}
