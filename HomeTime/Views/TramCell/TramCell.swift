import UIKit

class TramCell: UITableViewCell {

    func setup(tram: Tram) {
        let converter = DotNetDateConverter()
        
        textLabel?.text = converter.formattedDateFromString(tram.predictedArrivalDateTime) + converter.minutesLater(time: tram.predictedArrivalDateTime)
        detailTextLabel?.text = tram.destination
    }
    
    
}
