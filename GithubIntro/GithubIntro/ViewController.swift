import UIKit

class ViewController: UIViewController {

    // MARK: Constant

    private enum Constant {
        static let greeting = "Hi there 👋"

        enum Joke {
            static let setup = "What do you call a pile of kittens?         "
            static let punchline = "It's a meowntain.          "
        }
    }

    // MARK: Interface

    @IBOutlet private weak var ufoImageView: UIImageView! {
        didSet {
            ufoImageView.translatesAutoresizingMaskIntoConstraints = true
            ufo = Ufo(ufoImageView: ufoImageView)
        }
    }
    @IBOutlet private weak var greetingLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!

    private var ufo: Ufo?

    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ufo?.hide(in: view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        landUfo()
    }

    // MARK: Private Functions

    private func landUfo() {
        ufo?.enter(view) { [weak self] in
            self?.greetingLabel.typing(Constant.Joke.setup) { [weak self] in
                self?.greetingLabel.typing(Constant.Joke.punchline) { [weak self] in
                    guard let self = self else { return }
                    
                    self.greetingLabel.text = ""
                    
                    self.ufo?.leave(self.view) { [weak self] in
                        self?.messageLabel.typing(Constant.greeting)
                    }
                }
            }
        }
    }
}
