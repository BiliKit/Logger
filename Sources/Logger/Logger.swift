// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

//final class Logger {
//  static func logStatic(_ message: String) {
//    print(message)
//  }
//  func log(_ msg:String){
//    print(msg)
//  }
//}
//
//public func logtest(){
//  print("hello logger")
//}

public enum Log {
  enum LogLevel {
    case info
    case warning
    case error
    
    fileprivate var prefix: String {
      switch self {
      case .info: return "🟩 INFO"
      case .warning: return "🟨 WARNING"
      case .error: return "🟥 ERROR"
      }
    }
  }
  
  struct Context {
    let file: String
    let function: String
    let line: Int
    var description: String {
      "\((file as NSString).lastPathComponent):\(line) \(function)"
    }
  }
  
  public static func info(_ str: StaticString, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
    
    info(str.description, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
  }
  
  public static func info(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
    
    let context = Context(file: file, function: function, line: line)
    
    Log.handleLog(level: .info, str: str, shouldLogContext: shouldLogContext, context: context)
  }
  
  public static func warning(_ str: StaticString, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
    
    let context = Context(file: file, function: function, line: line)
    
    Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    
  }
  
  public static func error(_ str: StaticString, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
    
    error(str.description, shouldLogContext: shouldLogContext, file: file, function: function, line: line)
  }
  
  public static func error(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
    
    let context = Context(file: file, function: function, line: line)
    
    Log.handleLog(level: .error, str: str, shouldLogContext: shouldLogContext, context: context)
  }
  
  fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
    
    let logComponents = ["[\(level.prefix)]", str]
    var fullString = logComponents.joined(separator: " ")
    if shouldLogContext { fullString += " ➜ \(context.description)" }
    
    #if DEBUG
      print(fullString)
    #endif
  }
}
