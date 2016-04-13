//
//  ViewController.swift
//  Medical_App
//
//  Created by Gregory Johnson on 4/12/16.
//  Copyright © 2016 Gregory Johnson. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController, UITextFieldDelegate
{

    @IBOutlet weak var l_welcome: UILabel!
    @IBOutlet weak var l_placeHolder: UILabel!
    @IBOutlet weak var i_textInput: UITextField!
    
    let NameKey = "Name"
    let BirthdayKey = "Birthday"
    var nameID: AnyObject = "name"
    var birthday:NSDate = NSDate()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.i_textInput.delegate = self
        
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
    
    override func viewWillAppear(animated: Bool)
    {
        self.l_welcome.center.x -= self.view.bounds.width
        self.i_textInput.alpha = 0
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
            self.fadeOutWelcome()
        })
    }

    func fadeOutWelcome() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 0
            },
            completion: { finished in
                self.l_welcome.text = "Let's gather some information"
                self.fadeInGatherInfo()
            })
    }
    
    func fadeOutGatherInfo() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 0
            },
            completion: { finished in
                self.l_welcome.text = "Name"
                self.fadeInName()
            })
    }
    
    //Fades in the label
    //Uses cound to determine the step in the animation to do
    func fadeInGatherInfo() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 1
            },
            completion: { finished in
                print("Done")
                self.fadeOutGatherInfo()
            })
    }

    func fadeInName() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 1
                
                self.l_welcome.translatesAutoresizingMaskIntoConstraints = true
                var nextFrame = self.l_welcome.frame
                nextFrame.origin.y = self.l_placeHolder.frame.origin.y
                self.l_welcome.frame = nextFrame
                
                self.i_textInput.alpha = 1
            },
            completion: { finished in
                print(g_plist!.getValuesInPlistFile())
                print("Done moving and fading")
            })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if(g_plist != nil)
        {
            let dict = g_plist!.getMutablePlistFile()!
            dict[NameKey] = textField.text
            
            do {
                try g_plist?.addValuesToPlistFile(dict)
            } catch {
                print(error)
            }
            
            print(g_plist!.getValuesInPlistFile())
            
        }
        
        
        return false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    



