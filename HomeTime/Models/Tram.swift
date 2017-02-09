import Foundation
import ObjectMapper

class Tram: Mappable {
    
    var id: Int!
    var vehicleNo: Int!
    var routeNo: String!
    var predictedArrivalDateTime: String!
    var destination: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                       <- map["TripID"]
        vehicleNo                <- map["VehicleNo"]
        routeNo                  <- map["RouteNo"]
        predictedArrivalDateTime <- map["PredictedArrivalDateTime"]
        destination              <- map["Destination"]
    }
    
}
