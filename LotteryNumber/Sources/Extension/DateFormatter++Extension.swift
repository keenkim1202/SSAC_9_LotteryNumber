//
//  DateFormatter++Extension.swift
//  LotteryNumber
//
//  Created by KEEN on 2021/11/03.
//

import Foundation
import Foundation

extension DateFormatter {
  func toDate(date: String) -> Date {
    self.dateFormat = "yyyy-MM-dd"
    return self.date(from: date)!
  }
  
  func toString(date: Date) -> String {
    self.dateFormat = "yyyy-MM-dd"
    return self.string(from: date)
  }
}
