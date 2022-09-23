//
//  FeedItemViewController.swift
//  WebMDInterviewTest
//
//  Created by user228225 on 9/22/22.
//

import Foundation
import UIKit

class FeedItemViewController: UIViewController {
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedDescriptionLabel: UILabel!
    @IBOutlet weak var feedDetailsLabel: UILabel!
    
    var feedItemData: FeedItem = FeedItem.init(title: "", itemDescription: "", imageURL: nil, detail: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data to views
        self.title = feedItemData.title
        if let imageURL = feedItemData.imageURL {
            feedImageView.load(url: URL(string: imageURL)!)
        } else {
            feedImageView.isHidden = true
        }
        feedDescriptionLabel.text = feedItemData.itemDescription
        feedDetailsLabel.text = feedItemData.detail
    }
}
