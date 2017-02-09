import Foundation
import Alamofire
import SVProgressHUD

public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [[String : Any]]

public typealias FailureHandler = ((JSONDictionary) -> Void)?
public typealias CompletionHandler = ((JSONArray) -> Void)?

class BaseAPI {
    
    init() {
        
    }
    
    var isLoading: Bool = false
    
    lazy var tokenAPI: TokenAPI = {
        let api = TokenAPI()
        api.completionHandler = { [unowned self] json in
            let token = json.first!["DeviceToken"] as! String
            UserDefaults.standard.set(token, forKey: "DeviceToken")
            
            self.request()
        }
        api.failureHandler = { json in
            
        }
        
        return api
    }()
    
    var failureHandler: FailureHandler
    var completionHandler: CompletionHandler
    
    func apiPath() -> String {
        return ""
    }
    
    func params() -> JSONDictionary {
        var params: JSONDictionary = [:]
        
        params["aid"] = "TTIOSJSON"
        params["devInfo"] = "HomeTimeiOS"
        
        if let token = UserDefaults.standard.string(forKey: "DeviceToken") {
            params["tkn"] = token
        }
        
        return params
    }
    
    func request() {
        if !(self is TokenAPI) && UserDefaults.standard.string(forKey: "DeviceToken") == nil {
            tokenAPI.request()
            return
        }
        
        var urlString = "http://ws3.tramtracker.com.au/TramTracker/RestService/"
        urlString = urlString + apiPath()
        
        let manager = NetworkManager.sharedInstance.manager!
        isLoading = true
        
        manager.request(urlString, method: .get, parameters: params()).responseJSON { response in
            self.isLoading = false
            print("REQUEST: \(response.request!)")
            
            if let json  = response.result.value as? JSONDictionary {
                print("JSON: \(json)")
                
                if json["hasError"] as! Bool {
                    self.handleFailureResponse(json)
                    self.failureHandler?(json)
                    
                    let errorMessage = json["errorMessage"] as! String
                    SVProgressHUD.showError(withStatus: errorMessage)
                } else {
                    let responseObject = json["responseObject"] as! JSONArray
                    
                    self.handleCompletionResponse(responseObject)
                    self.completionHandler?(responseObject)
                }
            } else {
                self.failureHandler?([:])
                SVProgressHUD.showError(withStatus: response.result.error?.localizedDescription)
            }
        }
    }
    
    func handleCompletionResponse(_ response: JSONArray) {
        
    }
    
    func handleFailureResponse(_ response: JSONDictionary) {
        
    }

}
