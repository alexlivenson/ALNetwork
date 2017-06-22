//
//  Network.swift
//  Network
//
//  Created by alex livenson on 6/15/17.
//  Copyright © 2017 alex livenson. All rights reserved.
//

import Alamofire
import RxSwift

public class Network {
    
    public init() {
        
    }
    
    public func requestJSON(_ request: RequestType) -> Observable<Any> {
        return Observable.create { obs -> Disposable in
            let req = Alamofire.request(request)
                .validate()
                .responseJSON(completionHandler: { res in
                    switch res.result {
                    case .success(let val):
                        obs.onNext(val)
                        obs.onCompleted()
                    case .failure(let err):
                        obs.onError(err)
                    }
                })
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
    
    public func requestData(_ request: RequestType) -> Observable<Data> {
        return Observable.create { obs -> Disposable in
            let req = Alamofire.request(request)
                .validate()
                .responseData(completionHandler: { res in
                    switch res.result {
                    case .success(let val):
                        obs.onNext(val)
                        obs.onCompleted()
                    case .failure(let err):
                        obs.onError(err)
                    }
                })
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
    
    public func requestString(_ request: RequestType) -> Observable<String> {
        return Observable.create { obs -> Disposable in
            let req = Alamofire.request(request)
                .validate()
                .responseString(completionHandler: { res in
                    switch res.result {
                    case .success(let val):
                        obs.onNext(val)
                        obs.onCompleted()
                    case .failure(let err):
                        obs.onError(err)
                    }
                })
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
}
