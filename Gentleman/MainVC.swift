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
    @IBOutlet var txtSecret: UITextField!
    
    let keychain = Keychain(service: "com.sample.Gentleman")
    
    @IBOutlet weak var Button: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showCalibration), name: NSNotification.Name("ShowCalibration"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSettings), name: NSNotification.Name("ShowSettings"), object: nil)
        
    }
    
    @IBAction func openDoor(_ sender: Any) {
        if(twoFA() == true){
            if(Button.currentTitle == "OPEN"){
                Button.setTitle("CLOSE" , for: .normal)
            }
            else if(Button.currentTitle == "CLOSE"){
                Button.setTitle("OPEN" , for: .normal)
            }
        }
        
        /*
        let parameters : [String:Any] = [
            "EventName": "CreateJob",
            "JobID": "ijofsij234235",
            "JobDocument":[
                "job": "openDoor"
            ],
            "Targets":[
                "Things":["thing2","thing1","thingRandom"],
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
 */
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
}
