import Foundation

extension Date {
    func daysUntil(to birthday: Date) -> Int {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let date = cal.startOfDay(for: birthday)
        let components = cal.dateComponents([.day, .month], from: date)
        let nextDate = cal.nextDate(after: today, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
        return cal.dateComponents([.day], from: today, to: nextDate ?? today).day ?? 0
    }

    func years(calendar: Calendar = Calendar.current) -> Int {
        return calendar.dateComponents([.year], from: self, to: Date.now).year!
    }
}
