//
//  USStatesVC.swift
//  State&ZipTest
//
//  Created by Paresh Thakkar on 23/06/21.
//

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
        readPropertyList()
        btnBack.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackClicked(_ sender: UIButton) {
        didSelect = false
        btnBack.isHidden = true
        lblTop.text = "US States"
        tblStates.reloadData()
    }
    
}

extension USStatesVC {
    func readPropertyList() {
        if let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                mainDict = dic
                for data in mainDict
                {
                    statesArray.append(["StateName":data.key,"StatePin":data.value])
                }
            }
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
           // let Arr = nameDict["StatePin"] as! [Int]
         let pin = pinArray[indexPath.row]
            cell.lblName.text = "\(pin)"
        }
        return cell
        //statesArray = mainDict[indexPath.row] as![[String:Any]]
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
            
        }
    
    }
    
        
    }
//    func loadData() {
//        let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist")
////        let documentDirectory = path![0] as! String
////        let path = documentDirectory.appending("statedictionary.plist")
//        let fileManager = FileManager.default
//        if(!fileManager.fileExists(atPath: path!)){
//            if let bundlePath = Bundle.main.path(forResource: "myData", ofType: "plist"){
//                let result = NSMutableDictionary(contentsOfFile: bundlePath)
//                print("Bundle file myData.plist is -> \(result?.description)")
//                do{
//                    try fileManager.copyItem(atPath: bundlePath, toPath: path!)
//                }catch{
//                    print("copy failure.")
//                }
//            }else{
//                print("file myData.plist not found.")
//            }
//        }else{
//            print("file myData.plist already exits at path.")
//        }
//
//        let resultDictionary = NSMutableDictionary(contentsOfFile: path!)
//        print("load myData.plist is ->\((resultDictionary?.description)!)")
//
//        let myDict = NSDictionary(contentsOfFile: path!)
//        if let dict = myDict{
//            print(dict)
//           // myItemValue = dict.object(forKey: "myItemKey") as! String?
//         //   txtValue.text = myItemValue
//        }else{
//            print("load failure.")
//        }
//    }
//    func chipsOperationPropertyList(operation: chipsOperation) {
//        //chipOperation is enum for add, edit and update
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let path = paths.appending("/StoreData.plist")
//        let fileManager = FileManager.default
//        if (!(fileManager.fileExists(atPath: path)))
//        {
//            do {
//                let bundlePath : NSString = Bundle.main.path(forResource: "StoreData", ofType: "plist")! as NSString
//                try fileManager.copyItem(atPath: bundlePath as String, toPath: path)
//            }catch {
//               print(error)
//            }
//        }
//        var plistDict:NSMutableDictionary = NSMutableDictionary(contentsOfFile: path)!
//        switch operation {
//           case chipsOperation.add:
//                plistDict.setValue("Value", forKey: "Key")
//                break
//           case chipsOperation.edit:
//                plistDict["Key"] = "Value1"
//                break
//           case chipsOperation.delete:
//                plistDict.removeObject(forKey: "Key")
//                break
//        }
//        plistDict.write(toFile: path, atomically: true)
//    }

