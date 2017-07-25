//
//  ViewController.swift
//  MyMapKit
//
//  Created by Rafael M. Trasmontero on 5/10/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

import UIKit
import MapKit
class ViewController:UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var segmentView: UIView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
   
    @IBAction func mapTypeSegmentControl(_ sender: UISegmentedControl) {
        
        switch self.segmentControl.selectedSegmentIndex{
        case 1 :
            self.mapView.mapType = .hybrid
        case 2 :
            self.mapView.mapType = .satellite
        default:
            self.mapView.mapType = .standard
        }
    }

    var mapType:MKMapType = .standard  //.satelite // .hybrid
    
    //TURN TO TECH CLASS ANNOTATION
    class TurnToTech: NSObject ,MKAnnotation {
        var identifier:String = "center map"
        var title:String?
        var subtitle:String?
        var coordinate: CLLocationCoordinate2D
        
        var logoImageName:String?
        
        init(title:String?,subtitle:String?,coordinate:CLLocationCoordinate2D){
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
        }
    }
    
    //SEARCH TERM CLASS ANNOTATION
    class SearchTerm: NSObject ,MKAnnotation {
        var identifier:String = "Search Term"
        var title:String?
        var subtitle:String?
        var coordinate: CLLocationCoordinate2D
        
        var webURL:URL?
        var logoImageName:String?
        
        init(title:String?,subtitle:String?,coordinate:CLLocationCoordinate2D){
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
        }
    }
    
    //RESTAURANT LOCATION LIST CLASS
    struct RestaurantLocationList {
        
        var restaurantsArray = [Restaurant]()
        
        init(){
            restaurantsArray += [Restaurant(title: "Dunkin Donut", subtitle: "19 Rector St, New York, NY 10006, USA", coordinate: CLLocationCoordinate2DMake(40.70802719245363, -74.01396989822388))]
            
            restaurantsArray += [Restaurant(title: "Subway", subtitle: "106 Greenwich St, New York, NY 10006, USA", coordinate: CLLocationCoordinate2DMake(40.70852329864894, -74.01353001594543))]
            
            restaurantsArray += [Restaurant(title: "Starbucks", subtitle: "15-25 Carlisle St, New York, NY 10006, USA", coordinate: CLLocationCoordinate2DMake(40.70921458800388, -74.01414155960083))]
            
            restaurantsArray += [Restaurant(title: "O'Hara's", subtitle: "120 Cedar St, New York, NY 10006, USA", coordinate: CLLocationCoordinate2DMake(40.70950330084529, -74.01266634464264))]
            
            restaurantsArray += [Restaurant(title: "George's", subtitle: "46 Trinity Pl, New York, NY 10006, USA", coordinate: CLLocationCoordinate2DMake(40.70766527658617, -74.01339590549469))]
            
            restaurantsArray += [Restaurant(title: "TGIFridays", subtitle: "47 Broadway, New York, NY 10006, USA", coordinate: CLLocationCoordinate2DMake(40.70659578337154, -74.01301503181458))]
            
        }
        
    }
    
    
    //ARRAY OF RESTAURANT ANNOTATIONS
    let restaurants = RestaurantLocationList().restaurantsArray
 
    //DELEGATE VARIABLE
    var didSetStarting = false
    
    //RESTAURANT WEB URL
    var restaurantURL:URL?
    
    //SEARCH BUTTON/BAR
    var mySearchBar = UISearchBar()
    //SEARCH TERM
    var mySearchTerm:String?
    //SEARCH RESULTS ARRAY
    var searchResults = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        turnToTechAnnotation()
        cornerTurnTechLogo()
        segmentView.alpha = 0.50
        restaurantsAnnotations()
        initSearchBar()
        
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //METHOD TO LOAD RESTAURANT ANNOTATIONS TO MAP VIEW
    func restaurantsAnnotations(){
        mapView.addAnnotations(restaurants)
    }
    
    //SET STARTING VIEW AT TURN TO TECH W/ 150 METER RADIUS
    func setStartingView(){
    
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.70859649433212, -74.01491940021515), 300, 300), animated: true)
        
        didSetStarting = true
        
    }
    
    //ADD ANNOTATION/PIN TO TURN TO TECH
    func turnToTechAnnotation(){
       
        //create turntotech annotation
        let turnToTechPin = TurnToTech(title: "Turn To Tech", subtitle: "40 Rector St.", coordinate: CLLocationCoordinate2DMake(40.70859649433212,  -74.01491940021515))
        //add annotation
        mapView.addAnnotation(turnToTechPin)
    }
    
    //ADD TURN TO TECH IMAGE ON TOP LEFT CORNER
    func cornerTurnTechLogo(){
        let turnTechLogo = UIImageView(frame: CGRect(x: 0, y: 65, width: 50, height: 50))
        turnTechLogo.backgroundColor = .clear
        let imageToUse = UIImage.init(named: "tlogo")
        turnTechLogo.image = imageToUse
        mapView.addSubview(turnTechLogo)
    }
    
    //DELEGATE METHOD ZOOM IN TO LOCATION WHEN APP STARTS
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if fullyRendered && !didSetStarting{
            setStartingView()
        }
    }
    
    //DELEGATE METHOD, CUSTOMMIZE PINS
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //identifier class
        if let restaurant = annotation as? Restaurant{
            //reuse pins
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: restaurant.identifier) as? MKPinAnnotationView {
                return view
            }else{
                //make pins
                let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: restaurant.identifier)
                view.pinTintColor = .green
                view.isEnabled = true
                view.canShowCallout = true
                return view
            }
            
        }else{
            //identifier class
            if let turntotech = annotation as? TurnToTech{
                //reuse pin
                if let view = mapView.dequeueReusableAnnotationView(withIdentifier:turntotech.identifier) as? MKPinAnnotationView {
                    return view
                }else {
                    //make pin/callouts etc
                    let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier:turntotech.identifier)
                    view.pinTintColor = .black
                    view.isEnabled = true
                    view.canShowCallout = true
                    return view
                }
            }
        }
        return nil
    }
    
    //DELEGATE METHOD HANDLES IMAGES AND WEBSITES FOR CALLOUT VIEWS
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let currentView = view as MKAnnotationView
        let currentTitle = currentView.annotation?.title!
        
        let imageViewForCallOut = UIImageView(image: UIImage(named:calloutImage(title:currentTitle!)))
        imageViewForCallOut.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageViewForCallOut.contentMode = .scaleToFill
        currentView.leftCalloutAccessoryView = imageViewForCallOut
        
        let webButtonForCallOut = UIButton(type: .infoLight)
        if (restaurantURL == nil){
            restaurantURL = calloutWebURL(title: currentTitle!)
        }
        webButtonForCallOut.addTarget(self, action: #selector(goToWebsite), for: .touchUpInside)
        currentView.rightCalloutAccessoryView = webButtonForCallOut
        
    }
    
    //DELEGATE METHOD FOR ADDING ANNOTATIONS BASED ON SEARCH
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
    //METHOD TO ASSIGN IMAGES FOR USE IN CALL OUT VIEW
    func calloutImage(title:String) -> String{
        
        var imageName:String
        
        switch title{
        case "Dunkin Donut":
            imageName  = "dunkinDonutsLogo"
        case "Subway":
            imageName = "subwayLogo"
        case "Starbucks":
            imageName = "starbucksLogo"
        case "O'Hara's":
            imageName  = "oHarasLogo"
        case "George's":
            imageName = "georgesLogo"
        case "TGIFridays":
            imageName = "tgiFridaysLogo"
        default:
            imageName = "tlogo"
        }
        
        return imageName
    }
    
    //METHOD TO ASSIGN URLS FOR CALLOUT
    func calloutWebURL(title:String) -> URL{
        
        var webURL:URL
        
        switch title{
        case "Dunkin Donut":
            webURL = URL.init(string:"https://www.dunkindonuts.com/en")!
        case "Subway":
            webURL = URL.init(string: "http://www.subway.com/en-us")!
        case "Starbucks":
            webURL = URL.init(string: "https://www.starbucks.com/")!
        case "O'Hara's":
            webURL = URL.init(string: "http://www.oharaspubnyc.com/")!
        case "George's":
            webURL = URL.init(string: "http://georges-ny.com//")!
        case "TGIFridays":
            webURL = URL.init(string: "https://www.tgifridays.com/")!
        default:
            webURL = URL.init(string: "http://turntotech.io/")!
            
        }
        
        return webURL as URL
    }
    
    //METHOD TO GO TO RESTAURANT WEBSITE  "CLICK PIN TO GO TO WEBSITE"
    func goToWebsite(){
        if let myWebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebsiteViewController")as? WebsiteViewController{
            guard let urlForRestaurant = restaurantURL else {return}
            myWebViewController.webURL = urlForRestaurant as URL
            if let navigator = navigationController{
                navigator.pushViewController(myWebViewController, animated: true)
            }
        }
    }
    
    //#3 SEARCH
    //METHOD TO POPULATE MAP WITH LOCAL RESTAURTS USING SEARCH
    func populateNearByQueries(){
        
        
        //CLEAR PRIOR ANNOTATIONS FROM SEARCH RESULT
        searchResults.removeAll()
        
        //SET UP SEARCH
        let myRequest = MKLocalSearchRequest()
        myRequest.naturalLanguageQuery = " "
        
        //ASSIGN SEARCH TO VAR
        if let searchTerm = mySearchTerm{
            myRequest.naturalLanguageQuery = searchTerm
        }
        
        //SEARCH WITHIN THIS REGION // SAME AS TURN TO TECH
        myRequest.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.70859649433212, -74.01491940021515), 500, 500)
        
        //RUNS IN BACKGROUND THREAD
        let mySearch = MKLocalSearch(request: myRequest)
        
        mySearch.start { (response, error) in
            
            guard response != nil else {return}
            
            for item in (response?.mapItems)!{
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                let street = item.placemark.addressDictionary!["Street"] as! String
                let city = item.placemark.addressDictionary!["City"] as! String
                let state = item.placemark.addressDictionary!["State"] as! String
                let zipcode = item.placemark.addressDictionary!["ZIP"] as! String
                
                annotation.subtitle = "\(street), \(city), \(state), \(zipcode)"
                
                self.searchResults.append(annotation)
                
                DispatchQueue.main.async {
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.mapView.addAnnotations(self.searchResults)
                    self.turnToTechAnnotation()
                    self.restaurantsAnnotations()
                }
            }
        }
    }
    
    //METHODS TO LOAD SEARCH BAR
    func initSearchBar(){
        mySearchBar.placeholder = "Search For Stuff"
        mySearchBar.delegate = self
        self.navigationItem.titleView = mySearchBar
    }
    
    //#1 SEARCH
    
}

extension ViewController: UISearchBarDelegate {
    
    //SEARCH BAR DELEGATE METHODS
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm:String = mySearchBar.text else {return}
        mySearchTerm = searchTerm
        
        //handle keyboard
        searchBar.endEditing(true)
        
        print("\(mySearchTerm)")
        //CALL THE FUNCTION TO POPULATE SEARCH TERMS
        populateNearByQueries()
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}











