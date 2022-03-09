import UIKit

extension UIFont {
    static func altone(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}
