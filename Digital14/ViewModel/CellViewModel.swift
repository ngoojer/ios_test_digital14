
import Foundation

class CellViewModel {
    var element: Event
    var isFavourite = false
    init(element: Event) {
        self.element = element
    }
    var eventTitle: String { element.title}
    var displayLocation: String { element.venue.displayLocation}
    var imageURL: String? {element.performers.first?.image}
    
    var timeString: String {
        guard let date = CellViewModel.dateFormatterServer
                .date(from: element.datetimeUTC) else {fatalError("invalid date")}
        return CellViewModel.dateFormatterLocal.string(from: date)
    }
}

extension CellViewModel{
    private static let dateFormatterServer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
     }()
    
    private static let dateFormatterLocal: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy hh:mm a"
        formatter.timeZone =  TimeZone.current
        return formatter
     }()
}
