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
    @IBOutlet weak var i_textInput1: UITextField!
    @IBOutlet weak var i_textInput2: UITextField!
    @IBOutlet weak var i_textInput3: UITextField!
    @IBOutlet weak var l_title1: UILabel!
    @IBOutlet weak var l_title2: UILabel!
    @IBOutlet weak var l_title3: UILabel!
    @IBOutlet weak var b_back: UIButton!
    @IBOutlet weak var b_done: UIButton!
    
    @IBOutlet weak var p_datePicker: UIDatePicker!
    
    let FirstNameKey = "First Name"
    let MiddleInitialKey = "Middle Name"
    let LastNameKey = "Last Name"
    let BirthYearKey = "Birth Year"
    let BirthMonthKey = "Birth Month"
    let BirthDayKey = "Birth Day"
    
    let cornRad:CGFloat = 25        //Corner radius for the buttons in the view
    var stepNum:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.i_textInput1.delegate = self
        self.i_textInput2.delegate = self
        self.i_textInput3.delegate = self
        
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
        
        self.i_textInput1.alpha = 0
        self.i_textInput2.alpha = 0
        self.i_textInput3.alpha = 0
        self.l_title1.alpha = 0
        self.l_title2.alpha = 0
        self.l_title3.alpha = 0
        
        self.b_back.layer.cornerRadius = self.cornRad
        self.b_done.layer.cornerRadius = self.cornRad
        self.b_back.alpha = 0
        self.b_done.alpha = 0
        
        self.p_datePicker.alpha = 0
        self.p_datePicker.backgroundColor = UIColor.whiteColor()
        self.p_datePicker.layer.cornerRadius = self.cornRad
        self.p_datePicker.layer.masksToBounds = true;
    }
    
    
    //Moves in the welcome label
    func moveInWelcome() -> Void
    {
        UIView.animateWithDuration(1,
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
                self.l_welcome.font = UIFont(name: self.l_welcome.font.fontName, size: 30)
                self.fadeInGatherInfo()
            })
    }
    
    func fadeInGatherInfo() -> Void
    {
        UIView.animateWithDuration(1,
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
    
    func fadeOutGatherInfo() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.25,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 0
            },
            completion: { finished in
                self.l_welcome.text = "Full Name"
                self.l_welcome.font = UIFont(name: self.l_welcome.font.fontName, size: 36)
                self.fadeInName()
            })
    }
    
    func fadeInName() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 1
                self.b_back.alpha = 1
                self.b_done.alpha = 1
                
                self.l_welcome.translatesAutoresizingMaskIntoConstraints = true
                var nextFrame = self.l_welcome.frame
                nextFrame.origin.y = self.l_placeHolder.frame.origin.y
                self.l_welcome.frame = nextFrame
                
                self.i_textInput1.alpha = 1
                self.i_textInput2.alpha = 1
                self.i_textInput3.alpha = 1
                self.l_title1.alpha = 1
                self.l_title2.alpha = 1
                self.l_title3.alpha = 1
            },
            completion: { finished in
                print(g_plist!.getValuesInPlistFile())
                print("Done moving and fading")
            })
    }
    
    func fadeOutName() -> Void
    {
        self.b_done.enabled = false
        self.b_back.enabled = false
        UIView.animateWithDuration(0.5,
            delay: 0.25,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 0
                
                self.i_textInput1.alpha = 0
                self.i_textInput2.alpha = 0
                self.i_textInput3.alpha = 0
                self.l_title1.alpha = 0
                self.l_title2.alpha = 0
                self.l_title3.alpha = 0
            },
            completion: { finished in
                self.l_welcome.text = "Birthday"
                self.i_textInput1.text = ""
                self.i_textInput2.text = ""
                self.i_textInput3.text = ""
                self.fadeInBirthday()
            })
    }
    
    func fadeInBirthday() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                self.l_welcome.alpha = 1

                self.p_datePicker.alpha = 1
            },
            completion: { finished in
                self.b_done.enabled = true
                self.b_back.enabled = true
                print(g_plist!.getValuesInPlistFile())
                print("Done moving and fading")
            })
    }
    
    func nextStep()
    {
        switch stepNum
        {
        case 1:
            fadeOutName()
        default:
            print("stepNum is out of bounds")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Done button is clicked
    @IBAction func doneClicked(sender: AnyObject)
    {
         if(g_plist != nil)
         {
            let dict = g_plist!.getMutablePlistFile()!
            switch stepNum
            {
            case 0:
                dict[FirstNameKey] = self.i_textInput1.text
                dict[MiddleInitialKey] = self.i_textInput2.text
                dict[LastNameKey] = self.i_textInput3.text
            case 1:
                let components = self.p_datePicker.calendar.components([.Year, .Month, .Day], fromDate: p_datePicker.date)
                dict[BirthMonthKey] = components.month
                dict[BirthDayKey] = components.day
                dict[BirthYearKey] = components.year
            default:
                print("stepNum is out of bounds")
            }
         do {
            try g_plist?.addValuesToPlistFile(dict)
         } catch {
            print(error)
         }
            print(g_plist!.getValuesInPlistFile())
         }
        
        stepNum += 1
        nextStep()
    }
    
    //Back clicked
    @IBAction func backClicked(sender: AnyObject)
    {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    



