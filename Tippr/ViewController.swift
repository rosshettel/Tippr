//
//  ViewController.swift
//  Tippr
//
//  Created by Ross Hettel on 6/22/14.
//  Copyright (c) 2014 Ross Hettel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tipCalc = TipCalculatorModel()
    let tipAmounts = [0.15, 0.18, 0.20]
    
    @IBOutlet var subtotalTextField : UITextField
    @IBOutlet var tipLabel : UILabel
    @IBOutlet var totalLabel : UILabel
    @IBOutlet var selectedTipPercent : UISegmentedControl
    @IBOutlet var roundBillToggle : UISwitch
    
    @IBAction func viewTapped(sender : AnyObject) {
        subtotalTextField.resignFirstResponder()
    }
    
    @IBAction func subtotalUpdated() {
        var subtotal: Double = subtotalTextField.text.bridgeToObjectiveC().doubleValue
        tipCalc.updateSubtotal(subtotal)
        refreshUI()
    }
    
    @IBAction func toggleRoundUp() {
        var isRoundUp: Bool = roundBillToggle.on
        tipCalc.setRoundUp(isRoundUp)
        refreshUI()
    }
    
    @IBAction func switchTipAmount() {
        var selectedTip = tipAmounts[selectedTipPercent.selectedSegmentIndex]
        tipCalc.setTipPercent(selectedTip)
        refreshUI()
    }
    
    func refreshUI() {
        tipLabel.text = "$" + String(tipCalc.calculateTip())
        totalLabel.text = "$" + String(tipCalc.calculateTotal())
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController.navigationBar.tintColor = UIColor.blackColor()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

