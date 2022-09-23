import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /**
     1. Load the feed items using the FeedProvider.
     2. Display the feed items using a table view (following best practices for design). Each feed item should be contain the followings:
        a. An image loaded from the FeedItem imageUrl param (you can use the Foundation framework or any open source technology to load the image).
        b. If the imageUrl param is nil, you should only show the FeedItem's title and description.
        c. The FeedItem's title param below the image. This text should be a bit larger and bold.
        d. The FeedItem's description param below the title. This text should be a standard, but readable text size.
     3. Each feed item, when tapped, should push a new controller (you must create this new controller) that displays the corresponding FeedItem's parameters:
        a. The FeedItem's title param should be used as navigation bar title.
        b. At the top of the page, an image loaded from the FeedItem imageUrl param. (You can use the Foundation framework or any open source technology to load the image.)
        c. If the imageUrl param is nil, you should only show the FeedItem's title, description and details.
        d. The FeedItem's description parameter below the image. This text should be a standard, but readable text size.
        e. The FeedItem's detail parameter below the description. This text should be a standard, but readable text size.
            
     */
    private final var feedItems: [FeedItem] = []
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        // Loading JSON data as async
        DispatchQueue.main.async {
            self.feedItems = FeedProvider().readRemoveAndSort(resource: "data", ofType: "json")
            self.feedTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    // TableView method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    // TableView method to set each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedItem = feedItems[indexPath.row]
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! CustomTableCellController
        
        // Loading image from url otherwise it's hidden
        if let imageURL = feedItem.imageURL {
            cell.feedImageView.load(url: URL(string: imageURL)!)
        } else {
            cell.feedImageView.isHidden = true
        }
        cell.feedTitleLabel.text = feedItem.title
        cell.feedDescriptionLabel.text = feedItem.itemDescription
        return cell
    }
    
    // Push a new viewcontroller when an item is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = feedItems[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "FeedItemViewController") as! FeedItemViewController
        controller.feedItemData = feedItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
