//
//  ViewController.swift
//  TimerFramework
//
//  Created by Omer Cohen on 5/4/20.
//  Copyright © 2020 Omer Cohen. All rights reserved.
//

import UIKit

public class TimerViewController: UIViewController {
    
    public var tfTime: UITextField!
    public var timerLabel: UILabel!
    
    var counter = 60
    var timerStop: Timer?
    
    let myProjectBundle = Bundle(identifier: "com.omer.TimerFramework")!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        v.backgroundColor = UIColor(red: (64/255.0), green: (54/255.0), blue: (44/255.0), alpha: 0.9)
        view.addSubview(v)
        
        tfTime = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        tfTime.center = CGPoint(x: self.view.frame.width / 2, y: 200)
        tfTime.textAlignment = .center
        tfTime.textColor = .white
        tfTime.tintColor = .white
        let placeholder = NSAttributedString(string: "Set time", attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 0.6, alpha: 0.5)])
        tfTime.attributedPlaceholder = placeholder
        tfTime.borderStyle = UITextField.BorderStyle.bezel
        tfTime.keyboardType = UIKeyboardType.numberPad
        view.addSubview(tfTime)
        
        timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        timerLabel.center = CGPoint(x: self.view.frame.width / 2, y: 285)
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.font = .systemFont(ofSize: 30)
        timerLabel.text = "PleasePickTime"
        view.addSubview(timerLabel)
        
        //UIButton playBtn
        let playBtn = UIButton()
        if let image  = UIImage(named: "playImg", in: myProjectBundle, compatibleWith: nil) {
            playBtn.setImage(image, for: .normal)
        }
        playBtn.addTarget(self, action: #selector(didTapPlayBtn(_:)), for: .touchUpInside)
        playBtn.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        playBtn.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        //UIButton stopBtn
        let stopBtn = UIButton()
       
        if let image  =  UIImage(named: "stop", in: myProjectBundle, compatibleWith: nil) {
            stopBtn.setImage(image, for: .normal)
        }
        stopBtn.addTarget(self, action: #selector(didTapStopBtn(_:)), for: .touchUpInside)
        stopBtn.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        stopBtn.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        //UIButton pauseBtn
        let resetBtn = UIButton()
        if let image  = UIImage(named: "reset", in: myProjectBundle, compatibleWith: nil) {
            resetBtn.setImage(image, for: .normal)
        }
        resetBtn.addTarget(self, action: #selector(didTapResetBtn(_:)), for: .touchUpInside)
        resetBtn.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        resetBtn.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        //Stack View
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 20
        
        stackView.addArrangedSubview(stopBtn)
        stackView.addArrangedSubview(resetBtn)
        stackView.addArrangedSubview(playBtn)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func didTapResetBtn(_ tapGR: UITapGestureRecognizer) {
        if let text = tfTime.text{
            counter = Int(text) ?? 60
        }
        timerStop?.invalidate()
        timerLabel.text = "\(self.counter)"
    }
    
    @objc func didTapStopBtn(_ tapGR: UITapGestureRecognizer) {
        timerStop?.invalidate()
    }
    
    @objc func didTapPlayBtn(_ tapGR: UITapGestureRecognizer) {
        if let text = tfTime.text{
            counter = Int(text) ?? 60
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.counter -= 1
            self.timerLabel.text = "\(self.counter)"
            self.timerStop = timer
            if self.counter == 0 {
                timer.invalidate()
            }
        }
    }
}

