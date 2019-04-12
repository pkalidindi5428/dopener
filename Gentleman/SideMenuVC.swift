//
//  SideMenuVC.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 4/8/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0:         NotificationCenter.default.post(name: NSNotification.Name("ShowCalibration"), object: nil)
        default: break
        }
    }
}
