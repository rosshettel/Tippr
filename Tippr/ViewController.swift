//
//  ViewController.swift
//  Tippr
//
//  Created by Ross Hettel on 6/22/14.
//  Copyright (c) 2014 Ross Hettel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var totalTextField : UITextField
    @IBOutlet var taxPctSlider : UISlider
    @IBOutlet var taxPctLabel : UILabel
    @IBOutlet var resultsTextView : UITextView
    
    @IBAction func calculateTapped(sender : AnyObject) {
        tipCalc.total = Double(totalTextField.text.bridgeToObjectiveC().doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        
        for (tipPct, tipValue) in possibleTips {
            results = "\(tipPct)%: \(tipValue)\n"
        }
        resultsTextView.text = results
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPercent = Double(taxPctSlider.value) / 100
    }
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPercent: 0.06)
    
    func refreshUI() {
        totalTextField.text = String(tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPercent) * 100
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        resultsTextView.text = ""
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

