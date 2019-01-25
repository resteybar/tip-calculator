//
//  SettingsViewController.swift
//  tip_calculator
//
//  Created by Raymond Esteybar on 1/23/19.
//  Copyright © 2019 Raymond Esteybar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var percentage_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func change_default_percentage(_ sender: Any) {
        // Access UserDefaults
        let defaults = UserDefaults.standard
        print(percentage_field.text!)
        defaults.set(Int(percentage_field.text!) ?? 10, forKey: "default_percentage")
        
        // Force UserDefaults to save.
        defaults.synchronize()
        
        // Notifies notification_fired() in ViewController
        //  - Automatically updates default_tip
        NotificationCenter.default.post(name: Notification.Name("tip_notification"), object: nil, userInfo: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
