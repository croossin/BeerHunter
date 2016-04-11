//
//  APIManager.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreLocation

class APIManager{
    var key = "XXXXXXXX"

    func fetchStyles(callback:([Style])->()) {
        var styles = [Style]()
        let apiURL = "http://api.brewerydb.com/v2/menu/styles?key=" + key + "&format=json"

        //Request info from BrewerdyDB
        Alamofire.request(.GET, apiURL).responseJSON(completionHandler: {response in
            //Checking for successful Response
            if response.result.value != nil {
                let json = JSON(response.result.value!)

                for (_, object) in json["data"]{
                    styles.append(Style(name: object["name"].stringValue, shortName: object["shortName"].stringValue, description: object["description"].stringValue, abvMin: object["abvMin"].doubleValue, abvMax: object["abvMax"].doubleValue, ibuMin: object["ibuMin"].intValue, ibuMax: object["ibuMax"].intValue, srmMin: object["srmMin"].intValue, srmMax: object["srmMax"].intValue))
                }
                print("Success! Calling back ViewController with data...")
                callback(styles)
            } else {
                print("Error while requesting data:")
                print(response.result.error?.localizedDescription)
                callback(styles)
            }
        })
    }

    func fetchBreweries(location:CLLocationCoordinate2D?, radius: CLLocationDistance?, callback:([Brewery])->()){
        var breweries = [Brewery]()

        let lat = String(location!.latitude)
        let lng = String(location!.longitude)
        let radius = String((radius! / 1.60934)/1000)

        let apiURL = "http://api.brewerydb.com/v2/search/geo/point?lat=" + lat + "&lng=" + lng + "&radius=" + radius + "&key=" + key + "&format=json"

        //Request info from BrewerdyDB
        Alamofire.request(.GET, apiURL).responseJSON(completionHandler: {response in
            //Checking for successful Response
            if response.result.value != nil {
                let json = JSON(response.result.value!)

                for (_, object) in json["data"]{
                    breweries.append(Brewery(name: object["brewery"]["nameShortDisplay"].stringValue, description: object["brewery"]["description"].stringValue, distance: object["distance"].doubleValue, type: object["locationTypeDisplay"].stringValue, address: object["streetAddress"].stringValue, phone: object["phone"].stringValue, website: object["website"].stringValue, lng: object["longitude"].doubleValue, lat: object["latitude"].doubleValue, icon: object["brewery"]["images"]["icon"].stringValue, squareImage: object["brewery"]["images"]["squareLarge"].stringValue))
                }
                print("Success! Calling back ViewController with data...")
                callback(breweries)
            } else {
                print("Error while requesting data:")
                print(response.result.error?.localizedDescription)
                callback(breweries)
            }
        })
    }
}