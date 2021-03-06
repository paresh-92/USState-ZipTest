import UIKit

class EditZipCodeVC: UIViewController {
    
    
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var lblPinCode: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    var headerName = ""
    var pin = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPinCode.text = pin
        self.btnBack.setTitle("<  " + headerName, for: .normal)
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnOKClicked(_ sender: UIButton) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("statedictionary.plist")
        let dic : NSMutableDictionary = NSMutableDictionary(contentsOfFile: path)!
        
        
        for data in dic
        {
            var pinArr = data.value as![String]
            for i in 0..<pinArr.count
            {
               // if pinArr.contains(lblPinCode.text!)
                let pin = pinArr[i]
                if pin == lblPinCode.text!
                {
                    if txtZipCode.text != ""
                    {
                        pinArr.remove(at: i)
                        pinArr.insert(txtZipCode.text!, at: i)
                        dic.removeObject(forKey: headerName)
                        dic.setObject(pinArr, forKey: headerName as NSCopying)
                        dic.write(toFile: path, atomically: false)
                        let vc = storyboard?.instantiateViewController(identifier: "USStatesVC") as! USStatesVC
                        self.navigationController?.pushViewController(vc, animated: false)
                        return
                    }
                    else
                    {
                        return
                    }
                }
            }
            
            
        }
        
       
    }
    
}
