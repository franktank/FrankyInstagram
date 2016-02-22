//
//  HomeViewController.swift
//  FrankyInstagram
//
//  Created by Franky Liang on 2/21/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var userMedia: [PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        serverRequest()
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        serverRequest()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath) as! HomeTableViewCell
        
        if (userMedia?[indexPath.row]["media"] != nil) {
            let imagePost = userMedia?[indexPath.section]["media"] as! PFFile
            imagePost.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    let image = UIImage(data: imageData!)
                    cell.homepostImageView.image = image
                }
            })
        }
        
        if (userMedia?[indexPath.row]["caption"] != nil) {
            cell.homepostCaptionLabel.text = userMedia![indexPath.section]["caption"] as? String
        }
        
        
        return cell
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (userMedia != nil) {
            return userMedia!.count
        }
        else {
            return 0
        }
    }
    
    
    func serverRequest() {
        let query = PFQuery(className: "UserMedia")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.userMedia = media
                self.tableView.reloadData()
                
                // do something with the array of object returned by the call
            } else {
                print(error?.localizedDescription)
            }
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
