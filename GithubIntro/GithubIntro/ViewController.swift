//
//  ViewController.swift
//  GithubIntro
//
//  Created by Alice Aponasko on 1/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var ufoImageView: UIImageView! {
        didSet {
            ufoImageView.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    @IBOutlet private weak var greetingLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ufoImageView.removeConstraints(ufoImageView.constraints)
        ufoImageView.frame = CGRect(
            x: -ufoImageView.frame.width,
            y: view.frame.height / 2,
            width: ufoImageView.frame.width,
            height: ufoImageView.frame.height
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateUfoIn(with: Int.random(in: 10...100)) { [weak self] in
            self?.greetingLabel.setTyping("What do you call a pile of kittens?          ") { [weak self] in
                self?.greetingLabel.setTyping("It's a meowntain.          ") { [weak self] in
                    self?.greetingLabel.text = ""
                    self?.animateUfoOut(with: Int.random(in: 10...100)) {}
                }
            }
        }
    }

    private func animateUfoIn(with yDiff: Int, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.ufoImageView.frame = CGRect(
                x: self.ufoImageView.frame.midX + self.ufoImageView.frame.width / 4,
                y: self.view.frame.height / 2 + CGFloat(yDiff),
                width: self.ufoImageView.frame.width,
                height: self.ufoImageView.frame.height
            )
        } completion: { [weak self] _ in
            guard let self = self else { return }
            if self.ufoImageView.center.x <= self.view.center.x - self.ufoImageView.center.x / 4 {
                self.animateUfoIn(with: -Int.random(in: 10...100), completion: completion)
            } else {
                completion()
            }
        }
    }

    private func animateUfoOut(with yDiff: Int, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.ufoImageView.frame = CGRect(
                x: self.ufoImageView.frame.midX + self.ufoImageView.frame.width / 4,
                y: self.view.frame.height / 2 + CGFloat(yDiff),
                width: self.ufoImageView.frame.width,
                height: self.ufoImageView.frame.height
            )
        } completion: { [weak self] _ in
            guard let self = self else { return }
            if self.ufoImageView.frame.minX <= self.view.frame.maxX + self.ufoImageView.frame.width {
                self.animateUfoOut(with: -Int.random(in: 10...100), completion: completion)
            } else {
                completion()
            }
        }
    }

}

extension UILabel {

    func setTyping(
        _ typingText: String,
        completion: @escaping () -> Void,
        characterDelay: TimeInterval = 10.0
    ) {
        text = ""

        let writingTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

            typingText.forEach { char in
                DispatchQueue.main.async {
                    self.text?.append(char)

                    if self.text == typingText {
                        Thread.sleep(forTimeInterval: characterDelay / 100)
                        completion()
                    }
                }
                Thread.sleep(forTimeInterval: characterDelay / 100)
            }
        }

        let queue = DispatchQueue(label: "labelTyping")
        queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }

}

