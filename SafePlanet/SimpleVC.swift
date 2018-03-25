 //
//  SimpleVC.swift
//  RadiumBrowser
//
//  Created by Dinara Kozhamzharova on 3/25/18.
//  Copyright © 2018 bslayter. All rights reserved.
//

import UIKit

class SimpleVC: UIViewController {

    @IBOutlet weak var pwdLabel: UILabel!
    @IBOutlet weak var usrLabel: UILabel!
    
    var usrStr: String?
    var pwdStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usrLabel.text = usrStr
        pwdLabel.text = pwdStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customInit(usrStr: String, pwdStr: String){
        self.usrStr = usrStr
        self.pwdStr = pwdStr
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
