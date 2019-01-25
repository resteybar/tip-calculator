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
        
        let defaults = UserDefaults.standard
        let default_tip = defaults.integer(forKey: "default_percentage")
        tip_control.setTitle(String(format: "%d%%", default_tip), forSegmentAt: 0)
        
        // * Used to Automatically update the default tip from different view
        //  - Tutorial used: https://www.youtube.com/watch?v=iztROUzjpM0
        NotificationCenter.default.addObserver(self, selector: #selector(notification_fired(_:)), name: Notification.Name("tip_notification"), object: nil)
    }
    
    // *
    @objc func notification_fired(_ notification: Notification) {
        let default_info = notification.userInfo
        
        if let new_perc = default_info?["default_percentage"] as? Int {
            tip_control.setTitle(String(format: "%d%%", new_perc), forSegmentAt: 0)
            
            let bill = Double(bill_field.text!) ?? 0
            
            let defaults = UserDefaults.standard
            let default_tip = defaults.integer(forKey: "default_percentage")
            let dec_default = Double(default_tip) / 100
            
            // Calculate tip & total
            let tip_percentages = [dec_default, 0.15, 0.2]
            let tip = bill * tip_percentages[tip_control.selectedSegmentIndex]
            let total = bill + tip
            
            print("DTip: \(default_tip)")
            print(" Tip: \(tip)\n")
            
            // Update tip & total labels
            tip_label.text = String(format: "$%.2f", tip)
            total_label.text = String(format: "$%.2f", total)
        }
    }

    @IBAction func calculate_tip(_ sender: Any) {
        // Get bill amount
        let bill = Double(bill_field.text!) ?? 0
        
        let defaults = UserDefaults.standard
        let default_tip = defaults.integer(forKey: "default_percentage")
        let dec_default = Double(default_tip) / 100
        
        // Calculate tip & total
        let tip_percentages = [dec_default, 0.15, 0.2]
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

