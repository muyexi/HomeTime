import Foundation

open class DotNetDateConverter: NSObject {
    
    open func dateFromDotNetFormattedDateString(_ string: String) -> Date! {
        let string = string as NSString
        
        let startPositionRange = string.range(of: "(")
        let endPositionRange = string.range(of: "+")
        
        if startPositionRange.location != NSNotFound && endPositionRange.location != NSNotFound {
            let startLocation = startPositionRange.location + startPositionRange.length
            
            let range = NSRange(location: startLocation, length: endPositionRange.location - startLocation)
            let dateAsString = string.substring(with: range) as NSString
            let unixTimeInterval = dateAsString.doubleValue / 1000
            
            return Date(timeIntervalSince1970: unixTimeInterval)
        }

        return nil
    }

    open func formattedDateFromString(_ string: String) -> String {
        let date = dateFromDotNetFormattedDateString(string)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        
        return formatter.string(from: date!)
    }
    
    open func minutesLater(time: String) -> String {
        let date = dateFromDotNetFormattedDateString(time) as NSDate
        let minutesLater = Int(date.minutesLaterThan(Date()))
        
        var string = ""
        if minutesLater <= 60 {
            string = " (\(minutesLater) min.)"
        } else {
            string = " (1 hour)"
        }
        
        return string
    }
    
}
