//
//  ViewController.swift
//  PhotoSearchExample3
//
//  Created by Vince Day on 9/28/15.
//  Copyright © 2015 Vince Day. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

  

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
            }

    override func viewDidAppear(animated: Bool) {
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "https://api.instagram.com/v1/tags/clararockmore/media/recent?client_id=e311dd29d01840f8987e58bc3b31121c",
            parameters: nil,
            success:
            {
                (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                //print("JSON: " + responseObject.description)
                
                if let dataArray = responseObject["data"] as? [AnyObject]
                {
                    var urlArray:[String] = []                  //1
                    for dataObject in dataArray
                    {               //2
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String
                        { //3
                            urlArray.append(imageURLString)     //4
                        }
                    }
                    self.scrollView.contentSize = CGSizeMake(320, 320 * CGFloat(dataArray.count))
                    for var i = 0; i < urlArray.count; i++ {
                        let imageView = UIImageView(frame: CGRectMake(0, 320*CGFloat(i), 320, 320))     //1
                        if let url = NSURL(string: urlArray[i]) {
                            imageView.setImageWithURL( url)                          //2
                            self.scrollView.addSubview(imageView)
                        }                    }
                }
            },
            
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription)
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

