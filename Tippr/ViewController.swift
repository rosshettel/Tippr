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

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet var subtotalTextField : UITextField!
    @IBOutlet var tipLabel : UILabel!
    @IBOutlet var totalLabel : UILabel!
    @IBOutlet var selectedTipPercent : UISegmentedControl!
    @IBOutlet var roundBillToggle : UISwitch!
    
    @IBAction func viewTapped(sender : AnyObject) {
//        subtotalTextField.resignFirstResponder()
    }
    
    @IBAction func subtotalUpdated() {
        let subtotal = NSString(string: subtotalTextField.text!).doubleValue
        tipCalc.setSubtotal(subtotal)
        refreshUI()
    }
    
    @IBAction func toggleRoundUp() {
        let isRoundUp: Bool = roundBillToggle.on
        tipCalc.setRoundUp(isRoundUp)
        refreshUI()
    }
    
    @IBAction func switchTipAmount() {
        let selectedTip = tipAmounts[selectedTipPercent.selectedSegmentIndex]
        tipCalc.setTipPercent(selectedTip)
        refreshUI()
    }
    
    func refreshUI() {
        tipLabel.text = "$" + (NSString(format:"%.2f", tipCalc.calculateTip()) as String)
        totalLabel.text = "$" + (NSString(format:"%.2f", tipCalc.calculateTotal()) as String)
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor .whiteColor()]
        // Do any additional setup after loading the view, typically from a nib.
        tipCalc.setTipPercent(0.18)
        subtotalTextField.becomeFirstResponder()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

