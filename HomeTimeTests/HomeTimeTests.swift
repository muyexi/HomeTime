import UIKit
import XCTest
@testable import HomeTime

class HomeTimeTests: XCTestCase {
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let id = String(describing: ViewController.self)
        
        viewController = storyboard.instantiateViewController(withIdentifier: id) as? ViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSections() {
        let number =  viewController.tableView.numberOfSections
        XCTAssert(number == 2)
    }
    
    func testSectionRows() {
        let north =  viewController.tableView.numberOfRows(inSection: 0)
        XCTAssert(north == 1)
        
        let south =  viewController.tableView.numberOfRows(inSection: 0)
        XCTAssert(south == 1)
        
        let cell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        let string = cell?.textLabel?.text
        
        XCTAssert(string!.contains("No upcoming trams"))
    }
    
    func testLoading() {
        let tram = Tram(JSON: ["PredictedArrivalDateTime": "/Date(1486682034000+1100)/"])!
        
        viewController.northTramsAPI.trams = [tram]
        viewController.southTramsAPI.trams = [tram]
        
        viewController.tableView.reloadData()
        
        let northCell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssert(northCell!.textLabel!.text!.contains("10:13AM"))
        
        let southCell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 1))
        XCTAssert(southCell!.textLabel!.text!.contains("10:13AM"))
    }
    
}
