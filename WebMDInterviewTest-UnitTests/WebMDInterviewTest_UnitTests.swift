import XCTest
@testable import WebMDInterviewTest

class WebMDInterviewTest_UnitTests: XCTestCase {
    
    /**
     1. Write 2 unit tests for the FeedItem model (valid decoding, invalid decoding)
     2. Write unit test for validating the filtering and sorting of the feed items.
     3. OPTIONAL: Write at least 1 unit test for a functionality you think that it needs to be covered by tests.
     */
    
    let response = FeedResponse(items: [
        FeedItem(title: "Z - The Magnific",
                 itemDescription: "Generic description",
                 imageURL: "https://i.picsum.photos/id/361/200/200.jpg?hmac=8pPTUqe61Cxj4FYarGS9vZKtqUSjAzxOQJ0zBIHq28o",
                 detail: "Detailed desciption"),
        FeedItem(title: "A - The Little Boy",
                 itemDescription: "Generic description number two",
                 imageURL: "https://i.picsum.photos/id/79/200/200.jpg?hmac=jnCRb6UX5VWA4Kxl91zIBXPa2iJJsmVwzbxrzt6TahQ",
                 detail: "Detailed desciption number two"),
        FeedItem(title: "S - The Newest Thing",
                 itemDescription: "Generic description number three",
                 imageURL: "https://i.picsum.photos/id/57/200/200.jpg?hmac=EAluVy04ceTUijEPw3vraS5dkJ6vtBD3HmNwvMI5f3k",
                 detail: "Detailed desciption number three"),
        FeedItem(title: "G - The Cool Guy",
                 itemDescription: "Generic description number four",
                 imageURL: "https://i.picsum.photos/id/57/200/200.jpg?hmac=EAluVy04ceTUijEPw3vraS5dkJ6vtBD3HmNwvMI5f3k",
                 detail: "Detailed desciption number four"),
        FeedItem(title: "G - The Cool Guy",
                 itemDescription: "Generic description number five",
                 imageURL: nil,
                 detail: "Detailed desciption number five")
    ])

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_FeedItem_validDecoding_shouldBeTrue() {
        // Given
        let received = FeedProvider().readItems(resource: "testing", ofType: "json")
        
        // Then
        XCTAssertTrue(received?.items is [FeedItem])
    }
    
    func test_FeedItem_invalidDecoding_shouldBeFalse() {
        // Given
        let received = FeedProvider().readItems(resource: "testinginvalid", ofType: "json")
        
        // Then
        XCTAssertFalse(received?.items is [FeedItem])
    }
    
    func test_FeedProvider_isSortedAndFiltered_shouldBeEqual() {
        // Given
        let expected = [
            FeedItem(title: "A - The Little Boy",
                     itemDescription: "Generic description number two",
                     imageURL: "https://i.picsum.photos/id/79/200/200.jpg?hmac=jnCRb6UX5VWA4Kxl91zIBXPa2iJJsmVwzbxrzt6TahQ",
                     detail: "Detailed desciption number two"),
            FeedItem(title: "G - The Cool Guy",
                     itemDescription: "Generic description number three",
                     imageURL: "https://i.picsum.photos/id/57/200/200.jpg?hmac=EAluVy04ceTUijEPw3vraS5dkJ6vtBD3HmNwvMI5f3k",
                     detail: "Detailed desciption number three"),
            FeedItem(title: "S - The Newest Thing",
                     itemDescription: "Generic description number three",
                     imageURL: "https://i.picsum.photos/id/57/200/200.jpg?hmac=EAluVy04ceTUijEPw3vraS5dkJ6vtBD3HmNwvMI5f3k",
                     detail: "Detailed desciption number three"),
            FeedItem(title: "Z - The Magnific",
                     itemDescription: "Generic description",
                     imageURL: "https://i.picsum.photos/id/361/200/200.jpg?hmac=8pPTUqe61Cxj4FYarGS9vZKtqUSjAzxOQJ0zBIHq28o",
                     detail: "Detailed desciption")
        ]
        // When
        let received = FeedProvider().removeDuplicatesAndSort(response: response)
        
        // Then
        XCTAssertEqual(received.map{$0.title}, expected.map{$0.title})
    }
    
    func test_UIImage_loadsImageFromURL_shouldNotBeEqual() {
        // Given
        let image: UIImageView = UIImageView()
        let url: String = "https://i.picsum.photos/id/690/200/200.jpg?hmac=DN6slU20ktSeMSXbM6U8BG_YHhebxEl3S70qNurkzk8"
        
        // When
        image.load(url: URL(string: url)!)
        
        // Then
        DispatchQueue.main.async {
            XCTAssertNotEqual(image.image, nil)
        }
    }
    
    func test_UIImage_loadsImageFromURL_shouldBeEqual() {
        // Given
        let image: UIImageView = UIImageView()
        let url: String = "https://noValidImageURL.com"
        
        // When
        image.load(url: URL(string: url)!)
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(image.image, nil)
        }
    }
}
