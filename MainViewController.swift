//
//  MainViewController.swift
//  This_or_This
//
//  Created by John Herrick on 8/6/16.
//  Copyright © 2016 John Herrick. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Quest {
    var id: Int
    var question: String
    var left: Int
    var right: Int
    
    init(id: Int, question: String, left: Int, right: Int) {
        self.id = id
        self.question = question
        self.left=left
        self.right=right
    }
}

class MainViewController: UIViewController {
    @IBOutlet weak var qlabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var screenNumber: NSString?
    var currQuestion: String?
    var num: Int = 0
    
    
    

    //Alamofire.request(.GET, "http://172.28.249.99/tot/newQuestion.php", parameters:["name":name!, "question":question!])
    override func viewDidLoad() {
        super.viewDidLoad()
        num=0;
        var someInts = [Quest]()
        
        Alamofire.request(.GET, "http://172.28.249.99/tot/getQuestions1.php")
            .responseJSON { response in
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                if let js = response.result.value {
                    //print("JSON: \(js)")
                    let json = JSON(js)
                    
                    for (index,subJson):(String, JSON) in json {
                        //Do something you want
                        //print(index)
                        //print(subJson[0])
                        
                        for (index2,subsubJson):(String, JSON) in subJson {
                            //Do something you want
                            //print(index)
                            //print(subsubJson)
                            var q = Quest(id: Int(subsubJson["id"].stringValue)!, question: subsubJson["content"].stringValue, left: subsubJson["yes"].int!, right: subsubJson["no"].int!)
                            someInts.append(q)
                        }
                        
                    }
                    print(someInts[self.num].question)
                    self.qlabel.text=someInts[self.num].question
                    
                    //print (info)
                    //for (key,subJson):(String, JSON) in json {
                        //Do something you want
                        //print(json[0])
                        //print(key)
                        //print(subJson)
                        //var q = Quest(id: Int(key)!, question: subJson.string!)
                        //someInts.append(q)
                    //}
                    
                }
                print(someInts)
                
        }
        
        /*
        Alamofire.request(.GET, "http://172.28.249.99/tot/test.php")
            .validate()
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                self.currQuestion = response.result.value
                self.qlabel.text=self.currQuestion
        }
*/
        //currQuestion = Alamofire.request(.GET, "http://172.28.249.99/tot/getQuestions.php")
        //self.qlabel.text = currQuestion
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "newQuestionSegue") {
            var detailController = segue.destinationViewController as! AddNewViewController;
            detailController.name = screenNumber
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
