import Foundation

extension Double {
    func roundToTenths() -> Double {
        return (self * 10).rounded() / 10
    }
}
