//
//  LatestDrawNumber.swift
//  LotteryNumber
//
//  Created by KEEN on 2021/11/03.
//

import Foundation

// MARK: Properties
let dateFormatter: DateFormatter = {
  let df = DateFormatter()
  df.locale = Locale(identifier: "ko-KR")
  df.dateFormat = "YYYY-MM-dd"
  
  return df
}()

let baseDate = "2021-10-07"
let calendar = Calendar.current
let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())

var total: Int = 0
let isLeapMonthDays = 29
var isLeapYearArray: [(year: Int, isLeap: Bool)] = []

let startDate = dateFormatter.toDate(date: "2002-12-07") // 로또 1회 추첨일
let startWeeks = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday, .day, .year], from: startDate)
var endWeeks = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday, .day, .year], from: Date()) // 오늘

func isLeapYear(_ year: Int) -> Bool { // 윤년인지 확인하는 함수
  let date = dateFormatter.toDate(date: "\(year)-02-01")
  let numberOfDays = calendar.range(of: .day, in: .month, for: date)!.upperBound - 1
  
  if numberOfDays == 29 {
    return true
  }
  return false
}

func getDrawNum() -> Int {
  // 연도별 윤년 여부를 배열에 추가
  for i in startWeeks.year! + 1..<endWeeks.year! {
    isLeapYearArray.append((i, isLeapYear(i)))
  }

  // isLeapYearArray에서 조건에 따른 1년의 토요일 횟수를 더하기
  for elem in isLeapYearArray {
    let date = dateFormatter.toDate(date: "\(elem.year)-01-01")
    let components =  calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday, .day, .year], from: date)
    
    if elem.isLeap == true { // 1년이 366일 때
      // 1월 1일이 금요일이면 -> total에 53 더하기
      if components.weekday == 6 { // 금요일이면
        total += 53
      } else {
        total += 52
      }
    } else { // 1년이 365일 때
      // 1월 1일이 토요일이면 -> total에 53 더하기
      if components.weekday == 7 {
        total += 53
      } else {
        total += 52
      }
    }
  }

  // 오늘이 토요일이 아닌 경우에는 지난주 토요일이 마지막 추첨일
  if endWeeks.weekday! < 7 {
    if let lastWeek = calendar.date(byAdding: .day, value: -7, to: Date()) {
      endWeeks = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday, .day], from: lastWeek)
      endWeeks.weekday = 7
    }
  }

  let startYearSatCount = 52 - startWeeks.weekOfYear!
  let endyearSatCount = endWeeks.weekOfYear!

  return total + startYearSatCount + endyearSatCount + 1 // 1회 추첨일이 토요일이므로 +1
}
