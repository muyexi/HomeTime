import UIKit
import Alamofire

class NetworkManager {
    static let sharedInstance = NetworkManager()
    let manager: SessionManager?
    
    init() {
        let configuration = URLSessionConfiguration.default
        manager = Alamofire.SessionManager(configuration: configuration)
    }
}
