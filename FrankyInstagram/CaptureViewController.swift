//
//  CaptureViewController.swift
//  FrankyInstagram
//
//  Created by Franky Liang on 2/21/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import EZLoadingActivity

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    var userMedia = UserMedia()
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    let vc = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onChooseImage(sender: AnyObject) {
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        postImageView.image = editedImage
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    @IBOutlet weak var onSubmit: UIButton!
    
    @IBAction func clickSubmit(sender: AnyObject) {
        EZLoadingActivity.show("Loading...", disableUI: false)
        if (postImageView.image != nil && captionField.text != "") {
           
            userMedia.postUserImage(postImageView.image!, withCaption: captionField.text!, withCompletion: { (success: Bool, error: NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                   
                    
                } else {
                    print("Posted Image Successfully")
                    EZLoadingActivity.hide()
                 
                }
            })
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
