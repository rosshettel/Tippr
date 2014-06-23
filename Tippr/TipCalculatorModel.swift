//
//  TipCalculatorModel.swift
//  Tippr
//
//  Created by Ross Hettel on 6/22/14.
//  Copyright (c) 2014 Ross Hettel. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    var total: Double
    var taxPercent: Double
    var subtotal: Double {
       get {
        return total / (taxPercent + 1)
       }
    }
    
    init(total:Double, taxPercent:Double) {
        self.total = total
        self.taxPercent = taxPercent
    }
    
    func calculateTip(tipPercent:Double) -> Double {
        return subtotal * tipPercent
    }
    
    func returnPossibleTips() -> Dictionary<Int, Double> {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:Double[] = [0.15, 0.18, 0.20]
        
        var retval = Dictionary<Int, Double>()
        for possibleTip in possibleTipsInferred {
            let intPercent = Int(possibleTip * 100)
            retval[intPercent] = calculateTip(possibleTip)
        }
        return retval
    }
    
}