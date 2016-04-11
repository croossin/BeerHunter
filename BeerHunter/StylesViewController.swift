//
//  PopularViewController.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import UIKit
import CarbonKit
import SVProgressHUD

let parallaxCellIdentifier = "parallaxCell"

class StylesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let apiManager = APIManager()
    var styles = [Style]()

    @IBOutlet weak var collectionView: UICollectionView!
    var refresh: CarbonSwipeRefresh = CarbonSwipeRefresh()

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh = CarbonSwipeRefresh(scrollView: self.collectionView)

        refresh.setMarginTop(0)
        refresh.colors = [UIColor.blueColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.greenColor()]
        self.view.addSubview(refresh)
        refresh.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        getStyles(true)
    }

    func getStyles(loadingIndicator: Bool){
        if(loadingIndicator) {SVProgressHUD.showWithStatus("Fetching all Beer Styles!")}
        //Callback for putting received Data in the UI
        let refreshCallback: ([Style]) -> Void = { styles in

            print("Trying to put received data in the UI...")

            //Checks for empty array and shows error message in case someting went wrong
            if styles.isEmpty {
                SVProgressHUD.showErrorWithStatus("Had trouble fetching beers!")
                self.refresh.endRefreshing()
                return
            }else{
                self.refresh.endRefreshing()
                SVProgressHUD.dismiss()
                self.styles = styles
                self.collectionView.reloadData()
            }
        }
        apiManager.fetchStyles({ styles in refreshCallback(styles)})
    }

    override func viewWillLayoutSubviews() {
        let flowLayout: UICollectionViewFlowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 30), self.view.frame.size.height/3) //divide with by how many ever columns you want
    }

    func refresh(sender: AnyObject) {
        getStyles(false)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if styles.isEmpty{
            return 0
        }else{
            return styles.count
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier(parallaxCellIdentifier, forIndexPath: indexPath) as! ParallaxCollectionViewCell
        if styles.isEmpty{
            parallaxCell.image = UIImage(named: "exis-logo")!
        }else{
            parallaxCell.image = UIImage(named: "exis-logo")!
            parallaxCell.avgAbv.text = "Avg. ABV: " + String(styles[indexPath.row].avgAbv())
            parallaxCell.name.text = styles[indexPath.row].shortName
        }

        return parallaxCell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selected item at: \(indexPath.row)")
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {return}
        guard let visibleCells = collectionView.visibleCells() as? [ParallaxCollectionViewCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / ImageHeight) * OffsetSpeed
            parallaxCell.offset(CGPointMake(0.0, yOffset))
        }
    }
    
}
