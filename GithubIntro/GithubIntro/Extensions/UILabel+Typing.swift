import UIKit

extension UILabel {

    func typing(
        _ typingText: String,
        completion: (() -> Void)? = nil,
        characterDelay: TimeInterval = 10.0
    ) {
        text = ""

        let writingTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

            typingText.forEach { char in
                DispatchQueue.main.async {
                    self.text?.append(char)

                    if self.text == typingText {
                        Thread.sleep(forTimeInterval: characterDelay / 10)
                        completion?()
                    }
                }
                Thread.sleep(forTimeInterval: characterDelay / 100)
            }
        }

        let queue = DispatchQueue(label: "labelTyping")
        queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }

}
