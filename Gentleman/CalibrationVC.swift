//
//  CalibrationVC.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 4/14/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//

import UIKit
import Firebase

class CalibrationVC: UIViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var stepperControl: UIStepper!
    
    @IBAction func stepper(_ sender: UIStepper) {
        distanceLabel.text = String(sender.value)
    }
    
    @IBAction func transition(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("ShowSpeed"), object: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLabel.text = String(Int(stepperControl.value))

        // Do any additional setup after loading the view
        NotificationCenter.default.addObserver(self, selector: #selector(showSpeed), name: NSNotification.Name("ShowSpeed"), object: nil)
    }
    
    @objc func showSpeed(){
        performSegue(withIdentifier: "ShowSpeed", sender: nil)
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
