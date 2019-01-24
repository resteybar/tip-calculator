//
//  ViewController.swift
//  tip_calculator
//
//  Created by Raymond Esteybar on 1/23/19.
//  Copyright © 2019 Raymond Esteybar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tip_label: UILabel!
    @IBOutlet weak var total_label: UILabel!
    @IBOutlet weak var bill_field: UITextField!
    @IBOutlet weak var tip_control: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func calculate_tip(_ sender: Any) {
        // Get bill amount
        let bill = Double(bill_field.text!) ?? 0
            
        // Calculate tip & total
        let tip_percentages = [0.1, 0.15, 0.2]
        let tip = bill * tip_percentages[tip_control.selectedSegmentIndex]
        let total = bill + tip
        
        // Update tip & total labels
        tip_label.text = String(format: "$%.2f", tip)
        total_label.text = String(format: "$%.2f", total)
    }
    
    // Applies to View
    @IBAction func on_tap(_ sender: Any) {
        // Dismiss Keyboard
        print("Hello")
        view.endEditing(true)
    }
}

