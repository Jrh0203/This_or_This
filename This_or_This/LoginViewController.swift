//
//  LoginViewController.swift
//  This_or_This
//
//  Created by John Herrick on 8/6/16.
//  Copyright © 2016 John Herrick. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "loginSegue") {
            var detailController = segue.destinationViewController as! MainViewController;
            detailController.screenNumber = self.usernameText.text
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
