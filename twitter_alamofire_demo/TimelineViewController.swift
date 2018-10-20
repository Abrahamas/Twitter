//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift
import OAuthSwiftAlamofire
import KeychainAccess

class TimelineViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    
    var refreshControl: UIRefreshControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullTorefresh(_:)) , for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.rowHeight = 160
        tableView.estimatedRowHeight = 200
        fetchTweets()
        // Do any additional setup after loading the view.
    }
    @objc func didPullTorefresh (_ refreshControl: UIRefreshControl) {
         fetchTweets()
    }
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            
           // self.acIndicator.startAnimating()
            if let tweets = tweets {
                self.tweets = tweets
               // self.acIndicator.stopAnimating()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
       cell.tweet = tweets[indexPath.row]
        return cell
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
         APIManager.shared.logout()
    }
    
    func favoriteTweet(tweet: Tweet) {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
