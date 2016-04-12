//
//  ViewController.swift
//  Medical_App
//
//  Created by Gregory Johnson on 4/12/16.
//  Copyright © 2016 Gregory Johnson. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var l_welcome: UILabel!
    
    let NameKey = "Name"
    let BirthdayKey = "Birthday"
    var nameID: AnyObject = "name"
    var birthday:NSDate = NSDate()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        moveInWelcome()
        
       /* To change and retrieve plist info
        //1
        if let plist = Plist(name: "User_Info") {
            //2
            let dict = plist.getMutablePlistFile()!
            dict[NameKey] = "Gregory"
            //3
            do {
                try plist.addValuesToPlistFile(dict)
            } catch {
                print(error)
            }
            //4
            print(plist.getValuesInPlistFile())
        } else {
            print("Unable to get Plist")
        }
         */
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.l_welcome.center.x -= self.view.bounds.width
    }
    
    
    //Moves in the welcome label
    func moveInWelcome() -> Void
    {
        UIView.animateWithDuration(0.75,
           delay: 0.0,
           options: .CurveEaseIn,
           animations: {
                self.l_welcome.center.x += self.view.bounds.width
            },
           completion: { finished in
            self.fadeOut(self.l_welcome, time: 1.0)
        })
    }
    
    //Fades out the inputted UIView object over time
    func fadeOut(object:UIView, time:Double) -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 0
            },
            completion: { finished in
                print("Faded out")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

