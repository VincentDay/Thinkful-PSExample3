//
//  ViewController.swift
//  PhotoSearchExample3
//
//  Created by Vince Day on 9/28/15.
//  Copyright © 2015 Vince Day. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    

  

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchInstagramByHashtag("dogs")
        
        
            }

    //MARK: Utility methods
    func searchInstagramByHashtag(searchString:String) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET( "https://api.instagram.com/v1/tags/\(searchString)/media/recent?client_id=c4fc61c4704949baab8825cf178e13fe",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let dataArray = responseObject["data"] as? [AnyObject] {
                    var urlArray:[String] = []
                    for dataObject in dataArray {
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            urlArray.append(imageURLString)
                        }
                    }
                    //display urlArray in ScrollView
                    self.scrollView.contentSize = CGSizeMake(320, 320 * CGFloat(dataArray.count))
                    
                    for var i = 0; i < urlArray.count; i++ {
                        let imageView = UIImageView(frame: CGRectMake(0, 320*CGFloat(i), 320, 320))
                        if let url = NSURL(string: urlArray[i]) {
                            imageView.setImageWithURL( url)
                            self.scrollView.addSubview(imageView)
                        }
                    }
                    
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription)
        })
        
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
            
        }
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchInstagramByHashtag(searchText)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

