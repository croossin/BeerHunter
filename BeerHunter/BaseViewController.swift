//
//  ViewController.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import UIKit
import CarbonKit
import RFAboutView_Swift
import SVProgressHUD

class BaseViewController: UIViewController, CarbonTabSwipeNavigationDelegate {

    var items:[AnyObject] = []

    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Hunter"
        items = ["Beer Types", "Local", "About"]
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        self.setUpStyle()
    }

    func setUpStyle(){
        let color: UIColor = UIColor(red: 24.0 / 255, green: 75.0 / 255, blue: 152.0 / 255, alpha: 1)
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = color
        self.navigationController!.navigationBar.barStyle = .BlackTranslucent
        carbonTabSwipeNavigation.toolbar.translucent = false
        carbonTabSwipeNavigation.setIndicatorColor(color)
        let size = ((self.view.frame.size.width)/CGFloat(self.items.count))
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(size, forSegmentAtIndex: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(size, forSegmentAtIndex: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(size, forSegmentAtIndex: 2)

        carbonTabSwipeNavigation.setNormalColor(UIColor.blackColor().colorWithAlphaComponent(0.6))
        carbonTabSwipeNavigation.setSelectedColor(color, font: UIFont.boldSystemFontOfSize(14))
    }

    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        switch index {
        case 0:
            return self.storyboard!.instantiateViewControllerWithIdentifier("PopularViewController") as! StylesViewController
        case 1:
            return self.storyboard!.instantiateViewControllerWithIdentifier("LocationViewController") as! LocationViewController
        case 2:
            let aboutView = RFAboutViewController(appName: "Beer Hunter", copyrightHolderName: "Exis, Inc.", contactEmail: "admin@exis.io", contactEmailTitle: "Contact us", websiteURL: NSURL(string: "http://my.exis.io"), websiteURLTitle: "Visit Website")
            let color = UIColor(red: 24.0 / 255, green: 75.0 / 255, blue: 152.0 / 255, alpha: 1)
            aboutView.addAdditionalButton("Privacy Policy", content: "Here's the privacy policy :)")
            aboutView.navigationBarBarTintColor = color
            aboutView.navigationBarTitleTextColor = UIColor.whiteColor()
            aboutView.headerTextColor = UIColor.grayColor()
            aboutView.headerBackgroundImage = UIImage(named: "exis-logo")
            return aboutView
        default:
            return self.storyboard!.instantiateViewControllerWithIdentifier("PopularViewController") as! StylesViewController
        }
    }
}

