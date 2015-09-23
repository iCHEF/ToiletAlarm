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
    
    @IBOutlet weak var alarmSetting: UISwitch!
    var isAlarm = false
    @IBAction func alarmTapped(sender: UISwitch) {
        isAlarm = sender.on
        if sender.on == false && self.alarmLabel.text == "快去!!!"{
            self.alarmLabel.text = "Available"
            self.alarmLabel.backgroundColor = UIColor.greenColor()
        }
        if sender.on == true && self.alarmLabel.text == "Available"{
            self.alarmLabel.text = "快去!!!"
            self.alarmLabel.backgroundColor = UIColor.grayColor()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            var temp = false
            ToiletLightHouseClient.sharedInstance.isToiletOccupied.subscribeNext{ nextStatus in
            switch nextStatus {
            case OccupationStatus.Available:
                if temp == true && self.isAlarm == true{
                    self.alarmLabel.text = "快去!!!"
                    self.alarmLabel.backgroundColor = UIColor.grayColor()
                    temp = false
                }else{
                    self.alarmLabel.text = "Available"
                    self.alarmLabel.backgroundColor = UIColor.greenColor()
                }

            case OccupationStatus.Occupied:
                self.alarmLabel.text = "Occupied"
                temp = true
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

