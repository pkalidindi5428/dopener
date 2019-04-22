//
//  SpeedVC.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 4/15/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//

import UIKit

class SpeedVC: UIViewController {

    @IBAction func transition(_ sender: UIButton) {
                        NotificationCenter.default.post(name: NSNotification.Name("ShowMain"), object: nil)
    }
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    @IBAction func slider(_ sender: UISlider) {
        speedLabel.text = String(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        speedLabel.text = String(Int(sliderValue.value))
        NotificationCenter.default.addObserver(self, selector: #selector(showMain), name: NSNotification.Name("ShowMain"), object: nil)
    }
    
    @objc func showMain(){
        performSegue(withIdentifier: "ShowMain", sender: nil)
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
