//
//  LoginJoinService.swift
//  First-RxSwift
//
//  Created by JoSoJeong on 2022/01/18.
//

import Foundation
import Moya
import RxSwift

class LoginJoinService {
    let provider = MoyaProvider<LoginJoinAPI>()
    
    func login(nickName: String, password: String) -> Observable<LoginResponse> {
        return self.provider.rx.request(.login(nickname: nickName, password: password))
            .filterSuccessfulStatusCodes()
            .map(LoginResponse.self)
            .asObservable()
      
    }
    
}
