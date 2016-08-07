//
//  AddNewViewController.swift
//  This_or_This
//
//  Created by John Herrick on 8/6/16.
//  Copyright © 2016 John Herrick. All rights reserved.
//

import UIKit
import Alamofire

class AddNewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var rightAddImage: UIImageView!
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

        // Do any additional setup after loading the view.
    }
    
    func imageTappedLeft(img: AnyObject)
    {
        // Your action
        print("tapped left")
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                //print("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            //print("Camera inaccessable", message: "Application cannot access the camera.")
        }
        
    }
    func imageTappedRight(img: AnyObject)
    {
        // Your action
        print("tapped right")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            let selectorToCall = Selector("imageWasSavedSuccessfully:didFinishSavingWithError:context:")
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, selectorToCall, nil)
        }
        imagePicker.dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user saves an image
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
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
        leftCaption=self.leftAddOption.text
        rightCaption=self.rightAddOption.text
        print("Question: \(question!)")
        print(Alamofire.request(.GET, "http://172.28.249.99/tot/newQuestion.php", parameters:["name":name!, "question":question!, "leftText":leftCaption!, "rightText":rightCaption!]))
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
