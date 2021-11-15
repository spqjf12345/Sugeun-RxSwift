//
//  URLRequest+Extensions.swift
//  First-RxSwift
//
//  Created by JoSoJeong on 2021/11/15.
//

import Foundation
import RxSwift
import RxCocoa
import simd

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap{ url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                let articleList = try? JSONDecoder().decode(T.self, from: data)
                return articleList!
            }.asObservable()
    }
}