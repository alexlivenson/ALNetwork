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
    public func requestJSON(_ request: RequestType) -> Observable<Any> {
        return Observable.create { obs -> Disposable in
            let req = Alamofire.request(request)
                .validate()
                .responseJSON(
                    completionHandler: self.handler(obs: obs)
                )
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
    
    public func requestData(_ request: RequestType) -> Observable<Data> {
        return Observable.create { obs -> Disposable in
            let req = Alamofire.request(request)
                .validate()
                .responseData(
                    completionHandler: self.handler(obs: obs)
                )
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
    
    public func requestString(_ request: RequestType) -> Observable<String> {
        return Observable.create { obs -> Disposable in
            let req = Alamofire.request(request)
                .validate()
                .responseString(
                    completionHandler: self.handler(obs: obs)
                )
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
    
    private func handler<T>(obs: AnyObserver<T>) -> ((DataResponse<T>) -> Void) {
        return { (res: DataResponse<T>) in
            switch res.result {
            case .success(let val):
                obs.onNext(val)
                obs.onCompleted()
            case .failure(let err):
                obs.onError(err)
            }
        }
    }
}
