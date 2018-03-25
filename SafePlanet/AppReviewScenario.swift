

import UIKit
import WaitForIt

struct AppReview: ScenarioProtocol {
    static var minEventsRequired: Int? = 3
    static var minSecondsSinceFirstEvent: TimeInterval? = 604800 // Seconds in a week
    static var maxExecutionsPermitted: Int? = 2
    static var minSecondsBetweenExecutions: TimeInterval? = 172800 // Seconds in two days
    
    static var maxEventsPermitted: Int? = nil
    static var customConditions: (() -> Bool)? = nil
}
