//
//  EditZipCodeVC.swift
//  State&ZipTest
//
//  Created by Paresh Thakkar on 23/06/21.
//

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
    }
}
