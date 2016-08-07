//
//  AddNewViewController.swift
//  This_or_This
//
//  Created by John Herrick on 8/6/16.
//  Copyright © 2016 John Herrick. All rights reserved.
//

import UIKit
import Alamofire

class AddNewViewController: UIViewController {
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var name: NSString?
    var question: NSString?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Username: \(name!)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func donePressed(sender: AnyObject) {
        question=self.questionField.text
        print("Question: \(question!)")
        print(Alamofire.request(.GET, "http://172.28.249.99/tot/newQuestion.php", parameters:["name":name!, "question":question!]))
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
