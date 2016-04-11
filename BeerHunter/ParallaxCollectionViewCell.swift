//
//  ParallaxCollectionViewCell.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import UIKit

let ImageHeight: CGFloat = 200.0
let OffsetSpeed: CGFloat = 25.0

class ParallaxCollectionViewCell: UICollectionViewCell {

    // AspectFill; 200 points.
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avgAbv: UILabel!

    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    func offset(offset: CGPoint) {
        imageView.frame = CGRectOffset(self.imageView.bounds, offset.x, offset.y)
    }

}
