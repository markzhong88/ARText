/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Popover view controller for app settings.
*/

import UIKit

extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }else{
            color = UIColor.white
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
    
}

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var fontSlider: UISlider!
    
    
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    let defaults = UserDefaults.standard

    
    static func registerDefaults() {
        
        if (UserDefaults.standard.object(forKey:"textDistance") == nil) {
            UserDefaults.standard.register(defaults: ["textDistance":10])
        }
        
        if (UserDefaults.standard.object(forKey:"textFont") == nil) {
            UserDefaults.standard.register(defaults: ["textFont":25])
        }
        
        if (UserDefaults.standard.object(forKey:"textColor") == nil) {
            UserDefaults.standard.setColor(color: UIColor.white, forKey: "textColor")
        }
        
        /*
        UserDefaults.standard.register(defaults: [
            "textDistance":1,
            "textColor":UIColor.white,
            "textFont":25
            ])
        */
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateSettings()
    }
	
	private func populateSettings() {
		//let defaults = UserDefaults.standard
        
		//debugModeSwitch.isOn = defaults.bool(for: Setting.debugMode)
        
        if (defaults.object(forKey: "textFont") != nil){
            
            print(defaults.float(forKey: "textFont"))
            fontSlider.value = defaults.float(forKey: "textFont")
            fontLabel.text = String(format: "%.0f", defaults.float(forKey: "textFont"))
        }else{
            print("no textFont value in userdefault")
        }
        
        
        if (defaults.object(forKey: "textDistance") != nil){
            distanceSlider.value = defaults.float(forKey: "textDistance")
            distanceLabel.text = String(format: "%.0f cm", defaults.float(forKey: "textDistance"))
        }else{
            print("no distance value in userdefault")
        }
        
        if (defaults.object(forKey: "textColor") != nil){
            //colorSlider.value = defaults.float(forKey: "textColor")
            print("got color")

        }else{
            print("no color value in userdefault")
        }
	}
    
    @IBAction func changeDistance(_ sender: UISlider) {
        
        distanceLabel.text = String(format: "%.0f cm", sender.value)
        defaults.set(sender.value, forKey: "textDistance")

    }
    
    @IBAction func changeFontSize(_ sender: UISlider) {
        fontLabel.text = String(Int(sender.value))
        defaults.set(CGFloat(sender.value), forKey: "textFont")
        
    }
    
    @IBAction func changeColor(_ sender: UISlider) {
        
        let color = uiColorFromHex(rgbValue: colorArray[Int(sender.value)])
        //selectedColor.backgroundColor = color
        defaults.setColor(color: color, forKey: "textColor")

    }
    
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
