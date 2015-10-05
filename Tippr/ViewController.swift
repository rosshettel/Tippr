//
//  ViewController.swift
//  Tippr
//
//  Created by Ross Hettel on 10/4/15.
//  Copyright © 2015 Ross Hettel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tipCalc = TipCalculatorModel()
    let tipAmounts = [0.15, 0.18, 0.20]
    
    @IBOutlet var subTotalTextField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var selectedTipPercent: UISegmentedControl!
    @IBOutlet var roundBillToggle: UISwitch!
    
    func refreshUI() {
        tipLabel.text = "$" + (NSString(format: "%.2f", tipCalc.calculateTip()) as String)
        totalLabel.text = "$" + (NSString(format: "%.2f", tipCalc.calculateTotal()) as String)
    }
    
    @IBAction func subtotalUpdated() {
        let subtotal = (subTotalTextField.text! as NSString).doubleValue
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
        tipCalc.setTipPercent(0.18)
        subTotalTextField.becomeFirstResponder()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

