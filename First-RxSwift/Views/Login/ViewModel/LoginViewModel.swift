//
//  LoginViewModel.swift
//  First-RxSwift
//
//  Created by JoSoJeong on 2022/01/17.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    private let loginUseCase: LoginUseCase
    
    let disposeBag = DisposeBag()
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    struct Input {
        let idTextfield: Observable<String>
        let passwordTextfield: Observable<String>
        let tapLoginButton: Observable<Void>
        let signInButton: Observable<Void>
        let findIDButton: Observable<Void>
        let findPWButton: Observable<Void>
    }
    
    struct Output {
        let enableLoginInButton = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToMain = PublishRelay<Bool>()
    }
    
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        Observable.combineLatest(input.idTextfield, input.passwordTextfield)
            .map{!$0.0.isEmpty && !$0.1.isEmpty }
            .bind(to: output.enableLoginInButton)
            .disposed(by: disposeBag)
        
        input.tapLoginButton
            .withLatestFrom( Observable.combineLatest(input.idTextfield, input.passwordTextfield))
            .bind { (id, password) in
                if(id.count < 0){
                    output.errorMessage.accept("아이디를 입력해주세요")
                    output.goToMain.accept(false)
                }else if(password.count < 0){
                    output.errorMessage.accept("비밀번호를 입력해주세요")
                    output.goToMain.accept(false)
                }else {
                    let userData = User(id: 0, nickName: id, password: password, phoneNumber: "")
                    self.loginUseCase.logIn(userData)
                    output.goToMain.accept(true)
                }
            
            }.disposed(by: disposeBag)

        return output
    }

}
