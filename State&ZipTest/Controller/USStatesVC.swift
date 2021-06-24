import UIKit

class USStatesVC: UIViewController {
    
    @IBOutlet weak var tblStates: UITableView!
    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    var mainDict : [String:Any] = [:]
    var statesArray : [Any] = []
    var didSelect = false
    var pinArray : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFile()
        btnBack.isHidden = true
    }
    @IBAction func btnBackClicked(_ sender: UIButton) {
        didSelect = false
        btnBack.isHidden = true
        lblTop.text = "US States"
        tblStates.reloadData()
    }
}
extension USStatesVC {
    func readFile()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("statedictionary.plist")
        let fileManager = FileManager.default
        
        //check if file exists
        if !fileManager.fileExists(atPath: path) {
            
            guard let bundlePath = Bundle.main.path(forResource: "statedictionary", ofType: "plist") else { return }
            
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: path)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
            }
        }
        let dic = NSDictionary(contentsOfFile: path) as! [String: Any]
        mainDict = dic
        for data in mainDict
        {
            statesArray.append(["StateName":data.key,"StatePin":data.value])
        }
        
    }
}
extension USStatesVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didSelect == false
        {
            return mainDict.count
        }
        else
        {
            return pinArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblStates.dequeueReusableCell(withIdentifier: "USStatesCell", for: indexPath) as! USStatesCell
        
        if didSelect == false
        {
            let nameDict = statesArray[indexPath.row] as! [String:Any]
            cell.lblName.text = (nameDict["StateName"] as! String)
        }
        else
        {
            let pin = pinArray[indexPath.row]
            cell.lblName.text = "\(pin)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if didSelect == false
        {
            didSelect = true
            let nameDict = statesArray[indexPath.row] as! [String:Any]
            pinArray = nameDict["StatePin"] as! [Any]
            lblTop.text = (nameDict["StateName"] as! String)
            btnBack.isHidden = false
            tblStates.reloadData()
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditZipCodeVC") as! EditZipCodeVC
            vc.headerName = lblTop.text ?? ""
            vc.pin = pinArray[indexPath.row] as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


