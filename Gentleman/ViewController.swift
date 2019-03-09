//
//  ViewController.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 3/6/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func open(_ sender: Any) {
        let parameters: Parameters = [
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
    }
}

