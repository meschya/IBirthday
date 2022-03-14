import UserNotifications

struct NotificationManager {
    static let instance = NotificationManager()
    
    func showNotification(_ namegiver: Namegiver) {
        let content = UNMutableNotificationContent()
        content.body = "Today is \(namegiver.name ?? "your friend ") birthday!  Don't forget to congratulate him!"
        content.sound = .default

        var dateComponents = Calendar.current.dateComponents([.month, .day], from: namegiver.date!)
        dateComponents.hour = 13
        dateComponents.minute = 00

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        let request = UNNotificationRequest(identifier: "NotificationManager",
                                            content: content,
                                            trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    private init() {}
}
