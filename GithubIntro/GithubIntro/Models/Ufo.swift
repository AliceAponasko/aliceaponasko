import UIKit

struct Ufo {

    // MARK: Constants

    private enum Constant {
        enum Animation {
            static let duration = 0.5
        }
    }

    // MARK: Properties

    let ufoImageView: UIImageView

    // MARK: Actions

    func enter(
        _ view: UIView,
        moving yDiff: Int = Int.random(in: 10...80),
        completion: @escaping () -> Void
    ) {
        UIView.animate(
            withDuration: Constant.Animation.duration,
            delay: 0,
            options: .curveLinear
        ) {
            ufoImageView.frame = CGRect(
                x: ufoImageView.frame.midX + ufoImageView.frame.width / 4,
                y: view.frame.height / 2 + CGFloat(yDiff),
                width: ufoImageView.frame.width,
                height: ufoImageView.frame.height
            )
        } completion: { _ in
            if ufoImageView.center.x <= view.center.x - ufoImageView.center.x / 4 {
                enter(view, moving: -Int.random(in: 10...80), completion: completion)
            } else {
                completion()
            }
        }
    }

    func leave(
        _ view: UIView,
        moving yDiff: Int = Int.random(in: 10...50),
        completion: @escaping () -> Void
    ) {
        UIView.animate(
            withDuration: Constant.Animation.duration,
            delay: 0,
            options: .curveLinear
        ) {
            ufoImageView.frame = CGRect(
                x: ufoImageView.frame.midX + ufoImageView.frame.width / 4,
                y: view.frame.height / 2 + CGFloat(yDiff),
                width: ufoImageView.frame.width,
                height: ufoImageView.frame.height
            )
        } completion: { _ in
            if ufoImageView.frame.minX <= view.frame.maxX + ufoImageView.frame.width {
                leave(view, moving: -Int.random(in: 10...50), completion: completion)
            } else {
                completion()
            }
        }
    }

    func hide(in view: UIView) {
        ufoImageView.removeConstraints(ufoImageView.constraints)
        ufoImageView.frame = CGRect(
            x: -ufoImageView.frame.width,
            y: view.frame.height / 2,
            width: ufoImageView.frame.width,
            height: ufoImageView.frame.height
        )
    }

}
