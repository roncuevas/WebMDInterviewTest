import Foundation


struct FeedProvider {
    
    /**
     1. Create a function that will use the ResourceReader to read the data.json file and map the data to the corresponding models.
     2. Any feed items with the same title are considered duplicates and should be removed.
     3. Sort the FeedItem objects in alphabetical order by title.
     4. Make sure not to block the main thread when this task is performed.
     Note that this function should be used by FeedViewController to get the array of filtered and sorted FeedItem objects.
     */
    
    // Read json file and call method to remove duplicates and sort
    func readRemoveAndSort(resource fileName: String, ofType fileType: String) -> [FeedItem] {
        guard let feedResponse = readItems(resource: fileName, ofType: fileType) else { return [] } // Call method to read json file
        return removeDuplicatesAndSort(response: feedResponse) // Call method to remove duplicates and sort
    }
    
    // Read json file and returns the FeedResponse
    func readItems(resource fileName: String, ofType fileType: String) -> FeedResponse? {
        var response: FeedResponse?
        do {
            response = try ResourceReader.read(resource: fileName, ofType: fileType)  // Reading 'data.json" file
        } catch {
            print("Error: \(error)")
        }
        return response // Returns FeedResponse
    }
    
    // Remove duplicates and sorts
    func removeDuplicatesAndSort(response: FeedResponse) -> [FeedItem] {
        var feedItems: [FeedItem] = []
        var uniqueTitles = Set<String>()
        feedItems = response.items.filter { // Removing duplicates
            guard !uniqueTitles.contains($0.title) else {
                return false
            }
            uniqueTitles.insert($0.title)
            return true
        }
        feedItems = feedItems.sorted{$0.title < $1.title} // Sorting by title
        return feedItems
    }
}
