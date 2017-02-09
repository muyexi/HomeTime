import Foundation
import ObjectMapper

class TramsAPI: BaseAPI {

    var stopId: String
    var trams: [Tram] = []
    
    init(stopId: String) {
        self.stopId = stopId
    }

    override func apiPath() -> String {
        return "GetNextPredictedRoutesCollection/\(stopId)/78/false/"
    }
    
    override func params() -> JSONDictionary {
        var params = super.params()
        params["cid"] = "2"
        
        return params
    }
    
    override func handleCompletionResponse(_ response: JSONArray) {
        trams = Mapper<Tram>().mapArray(JSONArray: response)!
    }
        
}
