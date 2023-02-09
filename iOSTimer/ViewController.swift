//
//  ViewController.swift
//  iOSTimer
//
//  Created by KimChoonSik on 2023/02/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    //가리키는 상대의 RC를 올리지 않도록 약한 참조, weak 키워드 사용
    //스토리보드를 활용해서 만들면 서로를 가리키는(강한 참조 사이클) 가능성이 있어서
    //기본 설정이 weak
    
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number: Int = 0
    
    //UIViewController 클래스에 있는 viewDidLoad 메서드를 재정의
    //앱의 화면에 들어오면 처음 실행하는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //보통 아래와 같이 세팅하는 요소들은 함수로 묶어서 viewDidLoad에서 호출
    //코드를 깔끔하게 !
    func configureUI() {
        mainLabel.text = Text.select.rawValue
        //슬라이더의 가운데 설정
        slider.setValue(0.5, animated: true)
        
    }
    
    //valueChanged -> 슬라이더 움직이면 값이 바뀜
    @IBAction func sliderChanged(_ sender: UISlider) {
        //슬라이더의 밸류값을 가지고 메인레이블의 텍스트 세팅
        
        number = Int(sender.value * 60)
        mainLabel.text = String(number) + Text.seconds.rawValue
        
        //        mainLabel.text = "\(seconds) 초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        //1초씩 지나갈 때마다 실행
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
        //클로저 안에서 캡처리스트를 통해 self를 한 번만 쓰면 클로저 내부 코드에서는 self 안써도 됨
    }
    
    
    
    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number) 초"
        } else {
            number = 0
            mainLabel.text = Text.select.rawValue
            
            //소리 나게 해야함
            timer?.invalidate()
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            
        }
    }
        @IBAction func resetButtonTapped(_ sender: UIButton) {
            //초기화
            configureUI()
            number = 0
            timer?.invalidate()
            //timer = nil
        }
    }
    
// 앱 만들기 접근
// 구글링
// 공식문서
// 타이머, 셀렉터 사용법
// 선 그리기
// 사운드 플레이
