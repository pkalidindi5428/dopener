//
//  MainVC.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 4/10/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//

import UIKit
import Alamofire
import LocalAuthentication
import KeychainAccess

class MainVC: UIViewController {
    
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var topHalf: UIImageView!
    @IBOutlet var txtSecret: UITextField!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var bottomHalf: UIImageView!
    @IBOutlet weak var openLabel: UIImageView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if(Button.currentImage == UIImage(named: "locked")){
            topHalf.center.x = 170
            topHalf.center.y = 390
            bottomHalf.center.x = 203
            bottomHalf.center.y = 422
            openLabel.image = UIImage(named: "open")
        }
            
        else if(Button.currentImage == UIImage(named: "unlocked")){
            topHalf.center.x = 220
            topHalf.center.y = 333
            bottomHalf.center.x = 154
            bottomHalf.center.y = 479
            openLabel.image = UIImage(named: "close")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showCalibration), name: NSNotification.Name("ShowCalibration"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSettings), name: NSNotification.Name("ShowSettings"), object: nil)
        
    }
    
    
    @IBAction func openDoor(_ sender: UIButton) {
        let identifier = UUID()
        if(twoFA() == true){
            let duration: Double = 2.0
            if(Button.currentImage == UIImage(named: "locked")){
                UIView.animate(withDuration: duration){
                    self.unlock()
                }
                Button.setImage(UIImage(named: "unlocked"), for: .normal)
                openLabel.image = UIImage(named: "open")
            }
            else if(Button.currentImage == UIImage(named: "unlocked")){
                UIView.animate(withDuration: duration){
                    self.lock()
                }
                Button.setImage(UIImage(named: "locked"), for: .normal)
                openLabel.image = UIImage(named: "close")
            }
        
         let parameters : [String:Any] = [
         "EventName": "CreateJob",
         "JobID": identifier.uuidString,
         "JobDocument":[
            "job": "openDoor"
         ],
         "Targets":[
         "Things":["raspberryPi"],
         "ThingGroups":["groupThatDoesn", "testThingGroup"]
         ],
         "TargetSelection":"CONTINUOUS"
         ]
    AF.request("https://0u7cqbl0h4.execute-api.us-east-2.amazonaws.com/default/jobsLambda", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{response in
         print("Request: \(String(describing: response.request))")   // original url request
         print("Response: \(String(describing: response.response))") // http url response
         print("Result: \(response.result)")                         // response serialization result
         
         if let json = response.result.value {
         print("JSON: \(json)") // serialized json response
         }
         
         if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
         print("Data: \(utf8Text)") // original server data as UTF8 string
         }
         }
        }
    }
    
    @objc func twoFA() -> Bool {
        var context = LAContext()
        context.localizedCancelTitle = "Enter Passcode"
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            //LAPolicy.deviceOwnerAuthentication
        }
        var out = false
        //faceIDLabel.isHidden = (state == .loggedin) || (context.biometryType != .faceID)
        let reason = "Verify your identity"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason : reason) {success, error in
            if success{
                out = true
            } else{
                out = false
            }
        }
        return out
    }
    
    @objc func showCalibration() {
        performSegue(withIdentifier: "ShowCalibration", sender: nil)
    }
    
    @objc func showSettings(){
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    
    @IBAction func onMoreTapped() {
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    func unlock(){
        topHalf.center.x = 220
        topHalf.center.y = 333
        bottomHalf.center.x = 154
        bottomHalf.center.y = 479
    }
    
    func lock(){
        topHalf.center.x = 170
        topHalf.center.y = 390
        bottomHalf.center.x = 203
        bottomHalf.center.y = 422
    }
}
