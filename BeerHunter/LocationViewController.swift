//
//  LocationViewController.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import UIKit
import DBMapSelectorViewController
import SVProgressHUD

class LocationViewController: UIViewController, DBMapSelectorManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    @IBAction func refreshBreweries(sender: AnyObject) {
        getBreweries()
    }

    var mapSelectorManager = DBMapSelectorManager()
    var locationManager = LocationManager()
    var apiManager = APIManager()
    private var embeddedviewController: BreweryTableViewController!

    var breweries = [Brewery]()

    var radius: CLLocationDistance? = 1000.00
    var location: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapSelectorManager = DBMapSelectorManager.init(mapView: mapview)
        self.mapSelectorManager.delegate = self
        mapview.delegate = self
        locationManager.fetchWithCompletion{location, error in
            if location != nil {
                self.mapSelectorManager.circleCoordinate = location!.coordinate
                self.mapSelectorManager.circleRadius = self.radius!
                self.mapSelectorManager.editingType = DBMapSelectorEditingType.Full
                self.mapSelectorManager.applySelectorSettings()
                self.getBreweries()
            }
            else{
                print("Error getting location")
                SVProgressHUD.showErrorWithStatus("Error getting location")
            }
        }
    }

    func getBreweries(){
        SVProgressHUD.showWithStatus("Fetching Local Breweries!")
        //Callback for putting received Data in the UI
        let refreshCallback: ([Brewery]) -> Void = { breweries in

            print("Trying to put received data in the UI...")

            //Checks for empty array and shows error message in case someting went wrong
            if breweries.isEmpty {
                SVProgressHUD.showErrorWithStatus("Had trouble fetching locations!")
                return
            }else{
                SVProgressHUD.showSuccessWithStatus("Gathered " + String(breweries.count) + " locations around you!")
                self.embeddedviewController.setBreweryList(breweries)
            }
        }
        apiManager.fetchBreweries(self.location, radius: self.radius, callback: { breweries in refreshCallback(breweries)})
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? BreweryTableViewController
            where segue.identifier == "EmbedSegue"{

            self.embeddedviewController = vc
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        return mapSelectorManager.mapView(mapview, viewForAnnotation: annotation)
    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        return mapSelectorManager.mapView(mapview, rendererForOverlay: overlay)
    }

    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.mapSelectorManager.mapView(mapview, regionDidChangeAnimated: true)
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        self.mapSelectorManager.mapView(mapview, annotationView: view, didChangeDragState: newState, fromOldState: oldState)
    }

    func mapSelectorManager(mapSelectorManager: DBMapSelectorManager!, didChangeRadius radius: CLLocationDistance) {
        self.radius = radius
    }

    func mapSelectorManager(mapSelectorManager: DBMapSelectorManager!, didChangeCoordinate coordinate: CLLocationCoordinate2D) {
        self.location = coordinate
    }
}
