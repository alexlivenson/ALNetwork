//
//  Request.swift
//  Network
//
//  Created by alex livenson on 6/15/17.
//  Copyright © 2017 alex livenson. All rights reserved.
//

import Alamofire

public enum HTTPMethod {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect
    
    var alamoMethod: Alamofire.HTTPMethod {
        switch self {
        case .options: return .options
        case .get: return .get
        case .head: return .head
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        case .trace: return .trace
        case .connect: return .connect
        }
    }
}

public protocol RequestType: URLRequestConvertible {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: [String: Any]? { get }
}

extension RequestType {
    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(
            url: url,
            method: method.alamoMethod,
            headers: headers
        )
        
        if let body = body, JSONSerialization.isValidJSONObject(body) {
            do {
                let appJSONHeader = "application/json"
                let data = try JSONSerialization.data(withJSONObject: body, options: [])
                request.setValue(appJSONHeader, forHTTPHeaderField: "Content-Type")
                request.setValue(appJSONHeader, forHTTPHeaderField: "Accept")
                request.httpBody = data
            } catch {
                log.warning("invalid json body")
            }
        }
        
        return request
    }
}
