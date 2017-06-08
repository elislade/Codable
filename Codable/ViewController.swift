//
//  ViewController.swift
//  Codable
//
//  Created by Eli Slade on 2017-06-08.
//  Copyright © 2017 Eli Slade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Post.list { posts in
//            guard let posts = posts else { return }
//            print(posts)
//        }
        
        User.list { users in
            guard let users = users else { return }
            print(users)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

