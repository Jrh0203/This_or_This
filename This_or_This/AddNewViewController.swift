//
//  AddNewViewController.swift
//  This_or_This
//
//  Created by John Herrick on 8/6/16.
//  Copyright © 2016 John Herrick. All rights reserved.
//

import UIKit
import Alamofire

class AddNewViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate {    @IBOutlet weak var rightAddImage: UIImageView!
    let picker = UIImagePickerController()
    @IBOutlet weak var leftAddImage: UIImageView!
    @IBOutlet weak var leftAddOption: UITextField!
    @IBOutlet weak var rightAddOption: UITextField!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var name: NSString?
    var question: NSString?
    var leftCaption: NSString?
    var rightCaption: NSString?
    var imagePicker: UIImagePickerController!
    var goLeft: Int = 0
    var leftUrl: String?
    var rightUrl: String?
    var leftImage: UIImage?
    var rightImage: UIImage?
    var id: String = "";

    
    //MARK: - Methods
    // An alert method using the new iOS 8 UIAlertController instead of the deprecated UIAlertview
    // make the alert with the preferredstyle .Alert, make necessary actions, and then add the actions.
    // add to the handler a closure if you want the action to do anything.
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Actions
    //get a photo from the library. We present as a popover on iPad, and fullscreen on smaller devices.
    @IBAction func photoFromLibrary(sender: UIBarButtonItem) {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        picker.modalPresentationStyle = .Popover
        presentViewController(picker,
                              animated: true,
                              completion: nil)//4
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    //take a picture, check if we have a camera first.
    @IBAction func shootPhoto(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            picker.modalPresentationStyle = .FullScreen
            presentViewController(picker,
                                  animated: true,
                                  completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Username: \(name!)")
        let imagePicker: UIImagePickerController! = UIImagePickerController()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTappedLeft:"))
        leftAddImage.userInteractionEnabled = true
        leftAddImage.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target:self, action:Selector("imageTappedRight:"))
        rightAddImage.userInteractionEnabled = true
        rightAddImage.addGestureRecognizer(tapGestureRecognizer2)
        picker.delegate = self
        // Do any additional setup after loading the view.
    }
    func imageTappedLeft(img: AnyObject)
    {
        // Your action
        print("tapped left")
        shootPhoto(self)
        goLeft = 0;
    }
    func imageTappedRight(img: AnyObject)
    {
        // Your action
        print("tapped right")
        shootPhoto(self)
        goLeft = 1;
    }
    
    //MARK: - Delegates
    //What to do when the picker returns with a photo
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        var path = info[UIImagePickerControllerMediaURL];
        print("dfasdf")
        print(path)
        if (goLeft==0)
        {
        leftImage=chosenImage
        leftAddImage.contentMode = .ScaleAspectFit //3
        leftAddImage.image = chosenImage //4
        }
        else{
            rightImage=chosenImage
            rightAddImage.contentMode = .ScaleAspectFit //3
            rightAddImage.image = chosenImage //4
        }
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
                                      completion: nil)
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
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
    func uploadWithAlamofire(image: UIImage, side: String) {
        //let image = UIImage(named: "myImage")!
        
        // define parameters
        let parameters = [
            "questionid": self.id,
            "side": side
        ]
        
        // Begin upload
        Alamofire.upload(.POST, "http://172.28.249.99/tot/addImage.php",
            multipartFormData: { multipartFormData in
                
                // import image to request
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    multipartFormData.appendBodyPart(data: imageData, name: "myFile", fileName: "myImage.png", mimeType: "image/png")
                }
                
                print("hello")
                
                // import parameters
                for (key, value) in parameters {
                    multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                    print(key+value+"\n")
                }
            },
            encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    print("success")
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        question=self.questionField.text
        leftCaption=self.leftAddOption.text
        rightCaption=self.rightAddOption.text
        print("Question: \(question!)")
        
        Alamofire.request(.GET, "http://172.28.249.99/tot/newQuestion.php", parameters:["name":name!, "question":question!, "leftText":leftCaption!, "rightText":rightCaption!])
            .validate()
            .responseString { response in
                //print("Success: \(response.result.isSuccess)")
                //print("Response String: \(response.result.value)")
                print(response.result.value)
                let fullNameArr = response.result.value!.componentsSeparatedByString("\"")
                self.id = fullNameArr[0]
                print(self.id)
                let fileURL = NSBundle.mainBundle().URLForResource("Default", withExtension: "png")
                self.uploadWithAlamofire(self.leftImage!, side: "left")
                self.uploadWithAlamofire(self.rightImage!, side: "right")
        }
        
        //Alamofire.upload(.POST, "http://172.28.249.99/tot/addImage.php?questionid="+id+"&side="+"left", file: fileURL)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
