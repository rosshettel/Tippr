//
//  TipCalculatorModel.swift
//  Tippr
//
//  Created by Ross Hettel on 6/22/14.
//  Copyright (c) 2014 Ross Hettel. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    var subtotal: NSDecimalNumber
    var tipPercent: NSDecimalNumber
    var roundUp: Bool

    let roundingBehavior = NSDecimalNumberHandler.decimalNumberHandlerWithRoundingMode(NSRoundingMode.RoundUp, scale: 2, raiseOnExactness: true, raiseOnOverflow: true, raiseOnUnderflow: true, raiseOnDivideByZero: true)
    let roundToInteger = NSDecimalNumberHandler.decimalNumberHandlerWithRoundingMode(NSRoundingMode.RoundUp, scale: 0, raiseOnExactness: true, raiseOnOverflow: true, raiseOnUnderflow: true, raiseOnDivideByZero: true)
    
    init() {
        self.subtotal = NSDecimalNumber.zero()
        self.tipPercent = NSDecimalNumber.zero()
        self.roundUp = false
    }
    
    func setSubtotal(subtotal:Double) {
        self.subtotal = NSDecimalNumber(double: subtotal)
    }
    
    func setTipPercent(tipPercent:Double) {
        self.tipPercent = NSDecimalNumber(double: tipPercent)
    }
    
    func setRoundUp(isRoundUp:Bool) {
        self.roundUp = isRoundUp
    }
    
    func calculateTip() -> Double {
        var tip = subtotal.decimalNumberByMultiplyingBy(tipPercent, withBehavior: roundingBehavior)

        if(roundUp) {
            var roundedTotal = NSDecimalNumber(double: self.calculateTotal())
            return roundedTotal.decimalNumberBySubtracting(subtotal, withBehavior: roundingBehavior).doubleValue
        } else {
            return tip.doubleValue
        }
    }
    
    func calculateTotal() -> Double {
        var tip = subtotal.decimalNumberByMultiplyingBy(tipPercent, withBehavior: roundingBehavior)
        var total = subtotal.decimalNumberByAdding(tip, withBehavior: roundingBehavior)

        if(roundUp) {
            return total.decimalNumberByRoundingAccordingToBehavior(roundToInteger).doubleValue
        } else {
            return total.doubleValue
        }
    }
    
}