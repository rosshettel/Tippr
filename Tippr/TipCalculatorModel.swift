//
//  TipCalculatorModel.swift
//  Tippr
//
//  Created by Ross Hettel on 6/22/14.
//  Copyright (c) 2014 Ross Hettel. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    var subtotal: Double
    var roundUp: Bool
    var tipPercent: Double
    
    init() {
        self.subtotal = 0.0
        self.roundUp = false
        self.tipPercent = 0.18
    }
    
    func updateSubtotal(subtotal:Double) {
        self.subtotal = subtotal
    }
    
    func setRoundUp(isRoundUp:Bool) {
        self.roundUp = isRoundUp
    }
    
    func setTipPercent(tipPercent:Double) {
        self.tipPercent = tipPercent
    }
    
    func calculateTip() -> Double {
        var tip = subtotal * tipPercent
        if(roundUp) {
            var roundedTotal = round(subtotal + tip)
            return roundedTotal - subtotal
        } else {
            return tip
        }
    }
    
    func calculateTotal() -> Double {
        var total = subtotal + (subtotal * tipPercent)
        if(roundUp) {
            return round(total)
        } else {
            return total
        }
    }
    
}