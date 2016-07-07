//
//  ViewController.swift
//  Medical_App
//
//  Created by Gregory Johnson on 4/12/16.
//  Copyright © 2016 Gregory Johnson. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    //Programatically create elements****
    @IBOutlet weak var l_welcome: UILabel!
    @IBOutlet weak var l_placeHolder: UILabel!
    @IBOutlet weak var b_back: UIButton!
    @IBOutlet weak var b_done: UIButton!
    
    //View Info
    var viewHeight:CGFloat!
    var viewWidth:CGFloat!
    
    //Labels
    var l_top:UILabel!
    var l_middle:UILabel!
    var l_bottom:UILabel!
    
    //Text inputs
    var i_textInputTop:UITextField!
    var i_textInputMiddle:UITextField!
    var i_textInputBottom:UITextField!
    
    //Picker
    var p_dates:UIDatePicker!
    
    var p_marStatus:UIPickerView!
    var data_marStatus = ["Single", "Married", "Divorced", "Widowed"]
    var marStatusVal:String!
    var p_sex:UIPickerView!
    var data_sex = ["Male", "Female"]
    var sexVal:String!
    var p_race:UIPickerView!
    var data_race = ["Caucasion", "Black", "Native American"]
    var raceVal:String!
    
    var p_denom:UIPickerView!
    var data_denom = ["Christianity", "Hinduism", "Islam"]
    var denomVal:String!
    var p_prefLang:UIPickerView!
    var data_prefLang = ["English", "French", "German", "Spanish", "Italian"]
    var prefLangVal:String!
    
    //Keys for the plist
    let FirstNameKey = "First Name"
    let MiddleNameKey = "Middle Name"
    let LastNameKey = "Last Name"
    
    let MotherFirstNameKey = "Mother First Name"
    let MotherMiddleNameKey = "Mother Middle Name"
    let MotherLastNameKey = "Mother Last Name"
    
    let BirthYearKey = "Birth Year"
    let BirthMonthKey = "Birth Month"
    let BirthDayKey = "Birth Day"
    
    let MarStatusKey = "Marital Status"
    let SexKey = "Sex"
    let RaceKey = "Race"
    
    let DenomKey = "Denomination"
    let PrefLangKey = "Preferred Language"
    
    let SocialSecNumKey = "Social Security Number"
    
    let AddrKey = "Address"
    let ZipKey = "ZIP Code"
    
    //Corner radius for the buttons in the view
    let cornRad:CGFloat = 25
    
    //Array and index for titles of each promt
    var prompt:[String] = ["Full Name", "Mother's Maiden Name", "Birthday", "Personal Info", "Personal Info - Cont", "Social Security Number", "Location", "Phone Numbers"];
    var promptIndex:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.viewHeight = self.view.frame.height
        self.viewWidth = self.view.frame.width
        
        let screenTap = UITapGestureRecognizer()
        screenTap.addTarget(self, action: #selector(WelcomeController.resignNumpad))
        self.view.addGestureRecognizer(screenTap)
        
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
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        //Initial view with everything hidden or off screen. Allows for the starting animation
        self.l_welcome.center.x -= self.view.bounds.width
        
        self.b_back.layer.cornerRadius = self.cornRad
        self.b_done.layer.cornerRadius = self.cornRad
        self.b_back.alpha = 0
        self.b_done.alpha = 0
    }
    
    //Number of columns in data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows in data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView
        {
        case p_marStatus:
            return data_marStatus.count
        case p_sex:
            return data_sex.count
        case p_race:
            return data_race.count
        case p_denom:
            return data_denom.count
        case p_prefLang:
            return data_prefLang.count
        default:
            return 1
        }
    }
    
    //Get value at specific point
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView
        {
        case p_marStatus:
            marStatusVal = data_marStatus[row]
            return marStatusVal
        case p_sex:
            sexVal = data_sex[row]
            return sexVal
        case p_race:
            raceVal = data_race[row]
            return raceVal
        case p_denom:
            denomVal = data_denom[row]
            return denomVal
        case p_prefLang:
            prefLangVal = data_prefLang[row]
            return prefLangVal
        default:
            return nil
        }
    }
    
    //Resign the number pad whenever the screen is tapped
    func resignNumpad()
    {
        self.view.endEditing(true)
    }
    
    //-----------------------------------------Beginning Animation-----------------------------------------
    //Step 1:
    //      Moves in the welcome label
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
    
    //Step 2:
    //      Fade out welcome and prepare "Let's gather some information"
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
                self.l_welcome.font = UIFont.systemFontOfSize(32)
                self.fadeInGatherInfo()
            })
    }
    
    //Step 3:
    //      Fade in "Let's gather some information"
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
                self.fadeOutTitles()
            })
    }
    //-----------------------------------------------------------------------------------------------------
    
    //Step 4:
    //      Fadout out title and prepare next title
    func fadeOutTitles() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.25,
            options: .CurveEaseIn,
            animations: {
                
                //Fade out all but the back and done buttons
                for sview in self.view.subviews as [UIView]
                {
                    if !(sview is UIButton)
                    {
                        sview.alpha = 0
                    }
                }
            },
            completion: { finished in
                if(g_plist != nil)
                {
                    self.l_welcome.text = self.prompt[self.promptIndex]
                    switch self.promptIndex
                    {
                    case 0: //Full Name - 3 labels and 3 text inputs
                        //Creates local variables to hold reused data (easily editable for each part)
                        let height = self.viewHeight * 0.08     //height of each text input is 8% of view height
                        let labelHeight = height * 0.8          //label height is 80% of each text input height
                        let width = self.viewWidth * 0.8        //width of each text input is 80% of the view width
                        
                        let beginX = self.viewWidth * 0.5       //starts each subview's leftmost side at the center
                        
                        let labelFontSize:CGFloat = 24          //font size for the labels
                        let inputFontSize:CGFloat = 24          //font size for the text inputs
                        
                        self.l_top = UILabel(frame: CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.3 - labelHeight, width, labelHeight))
                        self.l_top.textAlignment = NSTextAlignment.Center
                        self.l_top.font = UIFont.systemFontOfSize(labelFontSize)
                        self.l_top.text = "First Name"
                        
                        self.l_middle = UILabel(frame: CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.5 - labelHeight, width, labelHeight))
                        self.l_middle.textAlignment = NSTextAlignment.Center
                        self.l_middle.font = UIFont.systemFontOfSize(labelFontSize)
                        self.l_middle.text = "Middle Name"
                        
                        self.l_bottom = UILabel(frame: CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.7 - labelHeight, width, labelHeight))
                        self.l_bottom.textAlignment = NSTextAlignment.Center
                        self.l_bottom.font = UIFont.systemFontOfSize(labelFontSize)
                        self.l_bottom.text = "Last Name"
                        
                        self.l_top.alpha = 0
                        self.l_middle.alpha = 0
                        self.l_bottom.alpha = 0
                        
                        self.view.addSubview(self.l_top)
                        self.view.addSubview(self.l_middle)
                        self.view.addSubview(self.l_bottom)
                        
                        self.i_textInputTop = UITextField(frame: CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.3, width, height))
                        self.i_textInputTop.text = g_plist!.getMutablePlistFile()![self.FirstNameKey] as? String
                        self.i_textInputTop.textAlignment = NSTextAlignment.Center
                        self.i_textInputTop.font = UIFont.systemFontOfSize(inputFontSize)
                        self.i_textInputTop.borderStyle = UITextBorderStyle.RoundedRect
                        self.i_textInputTop.autocorrectionType = UITextAutocorrectionType.No
                        self.i_textInputTop.keyboardType = UIKeyboardType.Default
                        self.i_textInputTop.returnKeyType = UIReturnKeyType.Done
                        self.i_textInputTop.clearButtonMode = UITextFieldViewMode.WhileEditing;
                        self.i_textInputTop.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
                        self.i_textInputTop.delegate = self
                        
                        self.i_textInputMiddle = UITextField(frame: CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.5, width, height))
                        self.i_textInputMiddle.text = g_plist!.getMutablePlistFile()![self.MiddleNameKey] as? String
                        self.i_textInputMiddle.textAlignment = NSTextAlignment.Center
                        self.i_textInputMiddle.font = UIFont.systemFontOfSize(inputFontSize)
                        self.i_textInputMiddle.borderStyle = UITextBorderStyle.RoundedRect
                        self.i_textInputMiddle.autocorrectionType = UITextAutocorrectionType.No
                        self.i_textInputMiddle.keyboardType = UIKeyboardType.Default
                        self.i_textInputMiddle.returnKeyType = UIReturnKeyType.Done
                        self.i_textInputMiddle.clearButtonMode = UITextFieldViewMode.WhileEditing;
                        self.i_textInputMiddle.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
                        self.i_textInputMiddle.delegate = self
                        
                        self.i_textInputBottom = UITextField(frame: CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.7, width, height))
                        self.i_textInputBottom.text = g_plist!.getMutablePlistFile()![self.LastNameKey] as? String
                        self.i_textInputBottom.textAlignment = NSTextAlignment.Center
                        self.i_textInputBottom.font = UIFont.systemFontOfSize(inputFontSize)
                        self.i_textInputBottom.borderStyle = UITextBorderStyle.RoundedRect
                        self.i_textInputBottom.autocorrectionType = UITextAutocorrectionType.No
                        self.i_textInputBottom.keyboardType = UIKeyboardType.Default
                        self.i_textInputBottom.returnKeyType = UIReturnKeyType.Done
                        self.i_textInputBottom.clearButtonMode = UITextFieldViewMode.WhileEditing;
                        self.i_textInputBottom.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
                        self.i_textInputBottom.delegate = self
                        
                        self.i_textInputTop.alpha = 0
                        self.i_textInputMiddle.alpha = 0
                        self.i_textInputBottom.alpha = 0
                        
                        self.view.addSubview(self.i_textInputTop)
                        self.view.addSubview(self.i_textInputMiddle)
                        self.view.addSubview(self.i_textInputBottom)
                    case 1: //Mother's Maiden Name - 3 labels and 3 text inputs
                        let height = self.viewHeight * 0.08     //height of each text input is 8% of view height
                        let labelHeight = height * 0.8          //label height is 80% of each text input height
                        let width = self.viewWidth * 0.8        //width of each text input is 80% of the view width
                        
                        let beginX = self.viewWidth * 0.5       //starts each subview's leftmost side at the center
                        
                        self.l_top.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.3 - labelHeight, width, labelHeight)
                        self.l_middle.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.5 - labelHeight, width, labelHeight)
                        self.l_bottom.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.7 - labelHeight, width, labelHeight)
                        
                        self.l_top.text = "First Name"
                        self.i_textInputTop.text = g_plist!.getMutablePlistFile()![self.MotherFirstNameKey] as? String
                        self.l_middle.text = "Middle Name"
                        self.i_textInputMiddle.text = g_plist!.getMutablePlistFile()![self.MotherMiddleNameKey] as? String
                        self.l_bottom.text = "Last Name"
                        self.i_textInputBottom.text = g_plist!.getMutablePlistFile()![self.MotherLastNameKey] as? String
                        self.l_welcome.font = UIFont.systemFontOfSize(24)
                    case 2: //Date of Birth - 1 date picker
                        let beginX = self.viewWidth * 0.5       //starts leftmost side at the center
                        let beginY = self.viewHeight * 0.5      //starts the topmost side at the center
                        let width = self.viewWidth * 0.8
                        let height = self.viewHeight * 0.5
                        
                        self.p_dates = UIDatePicker(frame: CGRectMake(beginX - 0.5 * width, beginY - 0.5 * height, width, height))
                        self.p_dates.datePickerMode = UIDatePickerMode.Date
                        self.p_dates.backgroundColor = UIColor(white: 1, alpha: 0.5)
                        self.p_dates.layer.cornerRadius = self.cornRad
                        if((g_plist!.getMutablePlistFile()![self.BirthYearKey] as? Int) != 1900)
                        {
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "M/d/yyyy"
                            let strng = "\(g_plist!.getMutablePlistFile()![self.BirthMonthKey] as! Int)/\(g_plist!.getMutablePlistFile()![self.BirthDayKey] as! Int)/\(g_plist!.getMutablePlistFile()![self.BirthYearKey] as! Int)"
                            let date = dateFormatter.dateFromString(strng)
                            self.p_dates.date = date!
                        }
                        self.p_dates.layer.masksToBounds = true
                        self.p_dates.alpha = 0
                        
                        self.view.addSubview(self.p_dates)
                    case 3: //Marital Status, sex, race - 3 pickers and 3 labels
                        let beginX = self.viewWidth * 0.5       //starts leftmost side at the center
                        let width = self.viewWidth * 0.8        //width of each picker
                        let height = self.viewHeight * 0.12     //height of each picker
                        let labelHeight = height * 0.5
                        
                        self.p_marStatus = UIPickerView(frame: CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.3, width, height))
                        self.p_marStatus.dataSource = self
                        self.p_marStatus.delegate = self
                        self.p_marStatus.backgroundColor = UIColor(white: 1, alpha: 0.5)
                        self.p_marStatus.layer.cornerRadius = self.cornRad
                        self.p_marStatus.alpha = 0
                        
                        self.p_sex = UIPickerView(frame: CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.5, width, height))
                        self.p_sex.dataSource = self
                        self.p_sex.delegate = self
                        self.p_sex.backgroundColor = UIColor(white: 1, alpha: 0.5)
                        self.p_sex.layer.cornerRadius = self.cornRad
                        self.p_sex.alpha = 0
                        
                        self.p_race = UIPickerView(frame: CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.7, width, height))
                        self.p_race.dataSource = self
                        self.p_race.delegate = self
                        self.p_race.backgroundColor = UIColor(white: 1, alpha: 0.5)
                        self.p_race.layer.cornerRadius = self.cornRad
                        self.p_race.alpha = 0
                        
                        self.l_top.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.3 - labelHeight, width, labelHeight)
                        self.l_middle.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.5 - labelHeight, width, labelHeight)
                        self.l_bottom.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.7 - labelHeight, width, labelHeight)
                        self.l_top.text = "Marital Status"
                        self.l_middle.text = "Sex"
                        self.l_bottom.text = "Race"
                        
                        self.view.addSubview(self.p_marStatus)
                        self.view.addSubview(self.p_sex)
                        self.view.addSubview(self.p_race)
                    case 4: //Denomination, Preferred Language - 2 pickers and 2 labels
                        let beginX = self.viewWidth * 0.5       //starts leftmost side at the center
                        let width = self.viewWidth * 0.8        //width of each picker
                        let height = self.viewHeight * 0.12     //height of each picker
                        let labelHeight = height * 0.5

                        self.p_denom = UIPickerView(frame: CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.35, width, height))
                        self.p_denom.dataSource = self
                        self.p_denom.delegate = self
                        self.p_denom.backgroundColor = UIColor(white: 1, alpha: 0.5)
                        self.p_denom.layer.cornerRadius = self.cornRad
                        self.p_denom.alpha = 0
                        
                        self.p_prefLang = UIPickerView(frame: CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.65, width, height))
                        self.p_prefLang.dataSource = self
                        self.p_prefLang.delegate = self
                        self.p_prefLang.backgroundColor = UIColor(white: 1, alpha: 0.5)
                        self.p_prefLang.layer.cornerRadius = self.cornRad
                        self.p_prefLang.alpha = 0
                        
                        self.l_top.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.35 - labelHeight, width, labelHeight)
                        self.l_bottom.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.65 - labelHeight, width, labelHeight)
                        self.l_top.text = "Denomination"
                        self.l_bottom.text = "Preferred Language"
                        
                        self.view.addSubview(self.p_denom)
                        self.view.addSubview(self.p_prefLang)
                    case 5: //Social security number - 1 text input
                        self.i_textInputMiddle.text = ""
                        self.i_textInputMiddle.keyboardType = UIKeyboardType.NumberPad
                    case 6: //Address, zip and county code - 3 text inputs and 3 labels
                        let height = self.viewHeight * 0.08     //height of each text input is 8% of view height
                        let labelHeight = height * 0.8          //label height is 80% of each text input height
                        let width = self.viewWidth * 0.8        //width of each text input is 80% of the view width
                        let beginX = self.viewWidth * 0.5       //starts each subview's leftmost side at the center
                        
                        self.l_top.frame = CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.3 - labelHeight, width, labelHeight)
                        self.l_middle.frame = CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.5 - labelHeight, width, labelHeight)
                        self.l_bottom.frame = CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.7 - labelHeight, width, labelHeight)
                        
                        self.l_top.text = "Address"
                        self.l_middle.text = "ZIP Code"
                        self.l_bottom.text = "County Code"
                        
                        self.i_textInputTop.frame = CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.3, width, height)
                        self.i_textInputMiddle.frame = CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.5, width, height)
                        self.i_textInputBottom.frame = CGRectMake(beginX - (0.5 * width), self.viewHeight * 0.7, width, height)
                        
                        self.i_textInputTop.text = nil
                        self.i_textInputMiddle.text = nil
                        self.i_textInputBottom.text = nil
                    case 7: //Home phone, cell phone and work phone - 3 text input and 3 labels
                        let height = self.viewHeight * 0.08     //height of each text input is 8% of view height
                        let labelHeight = height * 0.8          //label height is 80% of each text input height
                        let width = self.viewWidth * 0.8        //width of each text input is 80% of the view width
                        
                        let beginX = self.viewWidth * 0.5       //starts each subview's leftmost side at the center
                        
                        self.l_top.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.3 - labelHeight, width, labelHeight)
                        self.l_middle.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.5 - labelHeight, width, labelHeight)
                        self.l_bottom.frame = CGRectMake(beginX - 0.5 * width, self.viewHeight * 0.7 - labelHeight, width, labelHeight)
                        
                        self.l_top.text = "Home Phone"
                        self.i_textInputTop.text = ""
                        self.l_middle.text = "Cell Phone"
                        self.i_textInputMiddle.text = ""
                        self.l_bottom.text = "Work Phone"
                        self.i_textInputBottom.text = ""
                    default:
                        print("Bad index")
                        
                    }
                    self.l_welcome.font = UIFont(name: self.l_welcome.font.fontName, size: 36) //Size should change based on title
                    self.fadeInTitles()
                }
            })
    }
    
    //Step 5:
    //      Fadein title and set location
    func fadeInTitles() -> Void
    {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                
                self.l_welcome.alpha = 1
                
                if(self.promptIndex == 0)
                {
                    
                    self.b_back.alpha = 1
                    self.b_done.alpha = 1
                    
                    self.l_welcome.translatesAutoresizingMaskIntoConstraints = true
                    var nextFrame = self.l_welcome.frame
                    nextFrame.origin.y = self.l_placeHolder.frame.origin.y
                    self.l_welcome.frame = nextFrame
                }
                
                //Fade in based on index
                switch self.promptIndex
                {
                case 0: //Full Name
                    self.l_top.alpha = 1
                    self.i_textInputTop.alpha = 1
                    self.l_middle.alpha = 1
                    self.i_textInputMiddle.alpha = 1
                    self.l_bottom.alpha = 1
                    self.i_textInputBottom.alpha = 1
                case 1: //Mother maiden name
                    self.l_top.alpha = 1
                    self.i_textInputTop.alpha = 1
                    self.l_middle.alpha = 1
                    self.i_textInputMiddle.alpha = 1
                    self.l_bottom.alpha = 1
                    self.i_textInputBottom.alpha = 1
                case 2: //Date of birth
                    self.p_dates.alpha = 1
                case 3: //Marital Status, sex, race
                    self.l_top.alpha = 1
                    self.l_middle.alpha = 1
                    self.l_bottom.alpha = 1
                    self.p_marStatus.alpha = 1
                    self.p_sex.alpha = 1
                    self.p_race.alpha = 1
                case 4: //Denomination, preferred language
                    self.l_top.alpha = 1
                    self.l_bottom.alpha = 1
                    self.p_denom.alpha = 1
                    self.p_prefLang.alpha = 1
                case 5: //Social Security Number
                    self.i_textInputMiddle.alpha = 1
                case 6: //Location
                    self.l_top.alpha = 1
                    self.i_textInputTop.alpha = 1
                    self.l_middle.alpha = 1
                    self.i_textInputMiddle.alpha = 1
                    self.l_bottom.alpha = 1
                    self.i_textInputBottom.alpha = 1
                case 7:
                    self.l_top.alpha = 1
                    self.i_textInputTop.alpha = 1
                    self.l_middle.alpha = 1
                    self.i_textInputMiddle.alpha = 1
                    self.l_bottom.alpha = 1
                    self.i_textInputBottom.alpha = 1
                default:
                    print("Bad index")
                }
            },
            completion: { finished in
                print(g_plist!.getValuesInPlistFile())
                print("Done moving and fading")
            })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Done button is clicked
    //Add to plist and then increment promtIndex
    @IBAction func doneClicked(sender: AnyObject)
    {
         if(g_plist != nil)
         {
            let dict = g_plist!.getMutablePlistFile()!
            switch promptIndex
            {
            case 0:
                //Full name (first - middle - last)
                dict[FirstNameKey] = self.i_textInputTop!.text
                dict[MiddleNameKey] = self.i_textInputMiddle!.text
                dict[LastNameKey] = self.i_textInputBottom!.text
                print("case 0")
            case 1:
                //Mother's full maiden name (first - middle - last)
                dict[MotherFirstNameKey] = self.i_textInputTop!.text
                dict[MotherMiddleNameKey] = self.i_textInputMiddle!.text
                dict[MotherLastNameKey] = self.i_textInputBottom!.text
                print("case 1")
            case 2:
                //Date of birth (month - day - year)
                let components = self.p_dates.calendar.components([.Year, .Month, .Day], fromDate: p_dates.date)
                dict[BirthMonthKey] = components.month
                dict[BirthDayKey] = components.day
                dict[BirthYearKey] = components.year
                print("case 2")
            case 3:
                //Marital status - sex - race
                dict[MarStatusKey] = marStatusVal
                dict[SexKey] = sexVal
                dict[RaceKey] = raceVal
                print("case 3")
            case 4:
                //Denomination - preferred language
                dict[DenomKey] = denomVal
                dict[PrefLangKey] = prefLangVal
                print("case 4")
            case 5:
                //Social Security Number
                print("case 5")
            case 6:
                //Address - country code
                print("case 6")
            case 7:
                //Phone numbers (home - work - cell)
                print("case 7")
            default:
                print("stepNum is out of bounds")
        }
         do
         {
            try g_plist?.addValuesToPlistFile(dict)
         }
         catch
         {
            print(error)
         }
            print(g_plist!.getValuesInPlistFile())
         }
        
        self.promptIndex += 1
        self.fadeOutTitles()
    }
    
    //Back clicked
    @IBAction func backClicked(sender: AnyObject)
    {
        self.promptIndex -= 1
        self.fadeOutTitles()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    



