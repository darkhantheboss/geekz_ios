

import Foundation
import RealmSwift

class HistoryEntry: Object {
	@objc dynamic var id = ""
	@objc dynamic var pageURL = ""
	@objc dynamic var pageTitle = ""
	@objc dynamic var visitDate = Date(timeIntervalSince1970: 1)
	
	override class func primaryKey() -> String? {
		return "id"
	}
}
