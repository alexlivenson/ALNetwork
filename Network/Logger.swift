//
//  Logger.swift
//  Network
//
//  Created by alex livenson on 6/15/17.
//  Copyright © 2017 alex livenson. All rights reserved.
//

import Foundation

private extension DateFormatter {
    static var YYYYMMddHHmmss: DateFormatter {
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US")
        format.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return format
    }
}

// TODO: Alex L - This might be overkill, but loot into this
private enum LogLevel {
    case verbose
    case debug
    case info
    case warning
    case error
    
    var text: String {
        switch self {
        case .verbose: return "VERBOSE"
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        }
    }
}

protocol Loggable {
    func verbose(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int)
    func debug(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int)
    func info(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int)
    func warning(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int)
    func error(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int)
}

extension Loggable {
    func verbose(_ message: @autoclosure () -> Any, path: String = #file, function: String = #function, line: Int = #line) {
        verbose(message, path, function, line)
    }
    func debug(_ message: @autoclosure () -> Any, path: String = #file, function: String = #function, line: Int = #line) {
        debug(message, path, function, line)
    }
    func info(_ message: @autoclosure () -> Any, path: String = #file, function: String = #function, line: Int = #line) {
        info(message, path, function, line)
    }
    func warning(_ message: @autoclosure () -> Any, path: String = #file, function: String = #function, line: Int = #line) {
        warning(message, path, function, line)
    }
    func error(_ message: @autoclosure () -> Any, path: String = #file, function: String = #function, line: Int = #line) {
        error(message, path, function, line)
    }
}

final class Logger: Loggable {
    
    private let df = DateFormatter.YYYYMMddHHmmss
    
    func verbose(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int) {
        log(level: .debug, message)
    }
    
    func debug(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int) {
        log(level: .debug, message)
    }
    
    func info(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int) {
        log(level: .info, message)
    }
    
    func warning(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int) {
        log(level: .warning, message)
    }
    
    func error(_ message: @autoclosure () -> Any, _ path: String, _ function: String, _ line: Int) {
        log(level: .error, message)
    }
    
    private func log(level: LogLevel, _ message: @autoclosure () -> Any, _ path: String = #file, _ function: String = #function, _ line: Int = #line) {
        print("\(df.string(from: Date())) \(level.text) \(path).\(function):\(line) - \(message())" )
    }
}

let log = Logger()
