//
//  Brewery.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import Foundation
import UIKit

class Brewery{
    var name: String
    var description: String
    var distance: Double
    var type: String
    var address: String
    var phone: String
    var website: String
    var lng: Double
    var lat: Double
    var icon:NSURL
    var squareImage:NSURL

    init(name:String, description:String, distance:Double, type:String, address:String, phone:String, website:String, lng: Double, lat:Double, icon:String, squareImage: String){
        self.name = name
        self.description = description
        self.distance = distance
        self.type = type
        self.address = address
        self.phone = phone
        self.website = website
        self.lng = lng
        self.lat = lat
        self.icon = NSURL(string: icon)!
        self.squareImage = NSURL(string: squareImage)!
    }

}

extension Brewery{
    func downloadImage(completion: (image: UIImage?)->()){
        print("Download Started")
        getDataFromUrl(self.icon) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                completion(image: UIImage(data: data))
            }
        }
    }

    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}