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
import Charts

class Quest {
    var id: Int
    var question: String
    var left: Int
    var right: Int
    var leftWord: String
    var rightWord: String
    var leftCaption: String
    var rightCaption: String
    
    init(id: Int, question: String, left: Int, right: Int, leftWord: String, rightWord: String, leftCaption: String, rightCaption: String) {
        self.id = id
        self.question = question
        self.left=left
        self.right=right
        self.leftWord=leftWord
        self.rightWord=rightWord
        self.leftCaption=leftCaption
        self.rightCaption=rightCaption
    }
}

class MainViewController: UIViewController {
    @IBOutlet weak var leftButton: UILabel!
    @IBOutlet weak var rightButton: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var qlabel: UILabel!
    @IBOutlet var barChartView: BarChartView!
    var screenNumber: NSString?
    var currQuestion: String?
    var num: Int = 0
    var someInts = [Quest]()
    
    
    
    

    //Alamofire.request(.GET, "http://172.28.249.99/tot/newQuestion.php", parameters:["name":name!, "question":question!])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        num=0;
        
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTappedLeft:"))
            leftImage.userInteractionEnabled = true
            leftImage.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target:self, action:Selector("imageTappedRight:"))
        rightImage.userInteractionEnabled = true
        rightImage.addGestureRecognizer(tapGestureRecognizer2)
        
        
        
        
        
        
        
        
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
                            var q = Quest(id: Int(subsubJson["id"].stringValue)!, question: subsubJson["content"].stringValue, left: subsubJson["yes"].int!, right: subsubJson["no"].int!, leftWord: subsubJson["leftImage"].stringValue, rightWord: subsubJson["rightImage"].stringValue, leftCaption: subsubJson["leftText"].stringValue, rightCaption: subsubJson["rightText"].stringValue)
                            self.someInts.append(q)
                        }
                        
                    }
                    print("we got here")
                    var temp = "http://172.28.249.99/images/"+self.someInts[self.num].leftWord
                    //print(temp)
                    var temp2 = "http://172.28.249.99/images/"+self.someInts[self.num].rightWord
                    let url = NSURL(string: temp)
                    let url2 = NSURL(string: temp2)
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                        dispatch_async(dispatch_get_main_queue(), {
                            self.leftImage.image = UIImage(data: data!)
                            print("WOAH DUDE")
                        });
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        let data2 = NSData(contentsOfURL: url2!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                        dispatch_async(dispatch_get_main_queue(), {
                            self.rightImage.image = UIImage(data: data2!)
                            print("WOAH DUDE3")
                        });
                    }
                    self.updateThings()

                    
                    print(self.someInts[self.num].question)
                    self.qlabel.text=self.someInts[self.num].question
                    
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
                //print(self.someInts)
                
        }
        
    }
    
    func imageTappedLeft(img: AnyObject)
    {
        // Your action
        print("tapped left")
        Alamofire.request(.GET, "http://172.28.249.99/tot/vote.php", parameters:["questionid":someInts[self.num].id, "vote":"YES"])
        self.performSegueWithIdentifier("graphit", sender: self)
    }
    func imageTappedRight(img: AnyObject)
    {
        // Your action
        print("tapped right")
        Alamofire.request(.GET, "http://172.28.249.99/tot/vote.php", parameters:["questionid":someInts[self.num].id, "vote":"NO"])
        self.performSegueWithIdentifier("graphit", sender: self)
    }
    
    func updateThings(){
        print("update")
        self.leftButton.text=(someInts[self.num].leftCaption)
        print(self.someInts[self.num].leftCaption)
        self.rightButton.text=(someInts[self.num].rightCaption)
        self.qlabel.text=someInts[self.num].question
        
        
        var temp = "http://172.28.249.99/images/"+self.someInts[self.num].leftWord
        //print(temp)
        var temp2 = "http://172.28.249.99/images/"+self.someInts[self.num].rightWord
        let url = NSURL(string: temp)
        let url2 = NSURL(string: temp2)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            dispatch_async(dispatch_get_main_queue(), {
                self.leftImage.image = UIImage(data: data!)
                print("WOAH DUDE")
            });
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data2 = NSData(contentsOfURL: url2!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            dispatch_async(dispatch_get_main_queue(), {
                self.rightImage.image = UIImage(data: data2!)
                print("WOAH DUDE3")
            });
        }
    }

    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        if (self.num>0){
            self.num--}
        updateThings()
    }
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        if (self.num<self.someInts.count-1){
            self.num++}
        updateThings()
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
        if (segue.identifier == "graphit") {
            var detailController = segue.destinationViewController as! BarChartViewController;
            detailController.left = (someInts[self.num].left)
            detailController.right = (someInts[self.num].right)
        }
        
    }
    @IBAction func viewGraph(sender: AnyObject) {
        self.performSegueWithIdentifier("graphit", sender: self)
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
