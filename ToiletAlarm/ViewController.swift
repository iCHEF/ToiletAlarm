//
//  ViewController.swift
//  ToiletAlarm
//
//  Created by 呂紹淳 on 9/20/15.
//  Copyright © 2015 iCHEF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alarmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ToiletLightHouseClient.sharedInstance.isToiletOccupied.subscribeNext{ nextStatus in
            switch nextStatus {
            case OccupationStatus.Available:
                self.alarmLabel.text = "Available"
                self.alarmLabel.backgroundColor = UIColor.greenColor()
            case OccupationStatus.Occupied:
                self.alarmLabel.text = "Occupied"
                self.alarmLabel.backgroundColor = UIColor.redColor()
            case OccupationStatus.Unknown:
                self.alarmLabel.text = "Unknown"
                self.alarmLabel.backgroundColor = UIColor.yellowColor()
            }
        
        }
        
        
        ToiletLightHouseClient.sharedInstance.startService()
        ToiletLightHouseClient.sharedInstance.connect()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

