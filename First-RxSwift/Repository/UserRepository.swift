//
//  UserRepository.swift
//  First-RxSwift
//
//  Created by JoSoJeong on 2022/01/17.
//

import Foundation
import Moya
import RxSwift

protocol UserRepositoryType {
    func saveLoginInfo(userId: Int32, jwtToken: String)
    func logIn(nickName: String, password: String)
    func signUp(user: SignUpRequest) ->Observable<Int>
    func checkValidId(nickname: String) -> Observable<Int>
    func checkIdValid(nickname: String) -> Observable<Bool>
    func sendMessage(phoneNumber: String) -> Observable<Int>
}

protocol ProfileRepositoryType {
    func getUserInfo()
}

class UserRepository: UserRepositoryType {
    
    let userService: LoginJoinService
    let disposeBag = DisposeBag()
    
    init(userService: LoginJoinService){
        self.userService = userService
    }
    
    func saveLoginInfo(userId: Int32, jwtToken: String) {
        print("save login \(userId) \(jwtToken)")
        UserDefaults.standard.setValue(userId, forKey: UserDefaultKey.userID)
        UserDefaults.standard.setValue(jwtToken, forKey: UserDefaultKey.jwtToken)
    }
    
    func logIn(nickName: String, password: String) {
        userService.login(nickName: nickName, password: password).subscribe { loginResponse in
            self.saveLoginInfo(userId: loginResponse.userId, jwtToken: loginResponse.jwtToken)
        }.disposed(by: disposeBag)
        
    }
    
    
    func signUp(user: SignUpRequest) -> Observable<Int> {
        return userService.signUp(user: user)
    }
    
    func checkValidId(nickname: String) -> Observable<Int> {
        return userService.checkValidId(nickName: nickname)
    }
    
    func checkIdValid(nickname: String) -> Observable<Bool> {
        return userService.checkIdValid(nickName: nickname)
    }
    
    func sendMessage(phoneNumber: String) -> Observable<Int> {
        return userService.sendMessage(phoneNumber: phoneNumber)
    }
    
    
}

extension UserRepository: ProfileRepositoryType {
    func getUserInfo() {
        
    }
    
    
}
