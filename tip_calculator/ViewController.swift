//
//  ViewController.swift
//  tip_calculator
//
//  Created by Raymond Esteybar on 1/23/19.
//  Copyright © 2019 Raymond Esteybar. All rights reserved.
//

/*
    Extra Resources Used:
        NotificationCenter Tutorial
            - https://www.youtube.com/watch?v=iztROUzjpM0
        Animation Tutorial
            - https://www.raywenderlich.com/363-ios-animation-tutorial-getting-started
*/

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tip_label: UILabel!
    @IBOutlet weak var tip_title: UILabel!
    @IBOutlet weak var total_label: UILabel!
    @IBOutlet weak var total_title: UILabel!
    @IBOutlet weak var bill_field: UITextField!
    @IBOutlet weak var tip_control: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        let default_percentage = defaults.integer(forKey: "default_percentage")
        tip_control.setTitle(String(format: "%d%%", default_percentage), forSegmentAt: 0)
        
        // * Used to Automatically update the default tip from different view
        NotificationCenter.default.addObserver(self, selector: #selector(notification_fired(_:)), name: Notification.Name("tip_notification"), object: nil)
    }
    
    func update_info(is_notified: Bool) -> Void {
        // Get bill amount
        let bill = Double(bill_field.text!) ?? 0
        
        let defaults = UserDefaults.standard
        let default_percentage = defaults.integer(forKey: "default_percentage")
        let default_decimal = Double(default_percentage) / 100
        
        // Changes default tip %
        if (is_notified) {
            tip_control.setTitle(String(format: "%d%%", default_percentage), forSegmentAt: 0)
        }
        
        // Calculate tip & total
        let tip_percentages = [default_decimal, 0.15, 0.2]
        let tip = bill * tip_percentages[tip_control.selectedSegmentIndex]
        let total = bill + tip
        
        // Update tip & total labels
        tip_label.text = String(format: "$%.2f", tip)
        total_label.text = String(format: "$%.2f", total)
    }
    
    // Updating Default %
    //  - Codepath Solution
    //  - Setup for Animations
    override func viewWillAppear(_ animated: Bool) {
        tip_label.center.x -= view.bounds.width
        total_label.center.x -= view.bounds.width
        tip_title.center.x -= view.bounds.width
        total_title.center.x -= view.bounds.width
        
        update_info(is_notified: true)
    }
    
    // Animations
    override func viewDidAppear(_ animated: Bool) {
        
        // Ensures the # pad shows first
        bill_field.becomeFirstResponder()
        
        UIView.animate(withDuration: 0.8, delay: 0.0,
            options: [.autoreverse],
            animations: { () -> Void in
                self.bill_field.transform = CGAffineTransform(translationX: 0, y: -10)
            },
            completion: nil
        )
        
        UIView.animate(withDuration: 0.5) {
            self.tip_label.center.x += self.view.bounds.width
            self.tip_title.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [],
            animations: {
                self.total_label.center.x += self.view.bounds.width
                self.total_title.center.x += self.view.bounds.width
            },
            completion: nil
        )
    }
    
    //  - Youtube Solution
    //      * Updates Default % from SettingsViewController
    @objc func notification_fired(_ notification: Notification) {
        update_info(is_notified: true)
    }

    // * Edits to bill_field will update Tip & Total
    @IBAction func calculate_tip(_ sender: Any) {
        update_info(is_notified: false)
    }
    
    // Applies to View
    @IBAction func on_tap(_ sender: Any) {
        // Dismiss Keyboard
        view.endEditing(true)
    }
}

