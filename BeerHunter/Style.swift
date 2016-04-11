//
//  Styles.swift
//  BeerHunter
//
//  Created by Chase Roossin on 4/11/16.
//  Copyright © 2016 Exis. All rights reserved.
//

import Foundation

class Style{
    var name: String
    var shortName: String
    var description: String
    var abvMin: Double
    var abvMax: Double
    var ibuMin: Int
    var ibuMax: Int
    var srmMin: Int
    var srmMax: Int

    init(name: String, shortName: String, description: String, abvMin: Double, abvMax: Double, ibuMin: Int, ibuMax: Int, srmMin: Int, srmMax: Int){
        self.name = name
        self.shortName = shortName
        self.description = description
        self.abvMin = abvMin
        self.abvMax = abvMax
        self.ibuMin = ibuMin
        self.ibuMax = ibuMax
        self.srmMin = srmMin
        self.srmMax = srmMax
    }

    func avgAbv()->Double{
        return (abvMin+abvMax)/2
    }
}