//
//  ViewController.swift
//  Codable
//
//  Created by Eli Slade on 2017-06-08.
//  Copyright © 2017 Eli Slade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // navigationItem.largeTitleDisplayMode = .automatic
        
        let refCtrl = UIRefreshControl()
        refCtrl.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        
        tableView.refreshControl = refCtrl
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        loadData()
    }
    
    @objc func loadData(){
        User.list { users in
            guard let users = users else { return }
            self.users = users

            Post.list { posts in
                guard let posts = posts else { return }
                self.posts.append(contentsOf: posts)
                DispatchQueue.main.sync {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
}

extension Array {
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let post = posts[indexPath.row]
        let user = users.randomElement()
        cell.usernameLabel.text = user.name
        cell.userHandleLabel.text = "@\(user.username)"
        cell.mainLabel?.text = post.title.capitalized
        cell.subLabel?.text = post.body
        return cell
    }
}
