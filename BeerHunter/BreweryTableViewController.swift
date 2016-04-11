//
//  BreweryTableViewController.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/12/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import UIKit

let breweryCellIdentifier = "breweryCell"

class BreweryTableViewController: UITableViewController {

    var breweries = [Brewery]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setBreweryList(breweries: [Brewery]){
        self.breweries = breweries
        dispatch_async(dispatch_get_main_queue(),{ ()->() in
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(breweries.isEmpty){
            return 0
        }
        else{
            return breweries.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let breweryCell = tableView.dequeueReusableCellWithIdentifier(breweryCellIdentifier, forIndexPath: indexPath) as! BreweryTableViewCell
        breweryCell.name.text = breweries[indexPath.row].name
        breweries[indexPath.row].downloadImage { image in
            breweryCell.icon.image = image!
        }
        breweryCell.type.text = breweries[indexPath.row].type
        breweryCell.distance.text = "Distance: " + String(breweries[indexPath.row].distance) + "mi."
        breweryCell.address.text = breweries[indexPath.row].address
        return breweryCell
    }
}
