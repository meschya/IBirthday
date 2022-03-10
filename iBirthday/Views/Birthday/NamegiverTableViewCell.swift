import Confetto
import UIKit

final class NamegiverTableViewCell: UITableViewCell {
    // MARK: - Identifier
    
    static let identifier = "NamegiverTableViewCell"
    
    // MARK: - Properties
    
    // MARK: Private
    
    private let namegiverView: UIView = .init()
    private let namegiverStackView: NamegiverStackView = .init()
    private let confettiView: ConfettiView = .init()

    // MARK: - LIfecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        addSetups()
        addConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func set(_ image: UIImage, _ name: String, _ date: Date, _ dateForBirthday: String, _ yearsOld: Int) {
        namegiverStackView.set(image,
                               name,
                               date,
                               dateForBirthday,
                               yearsOld)
    }
    
    func hiddenForBirthdayImage() {
        namegiverStackView.hiddenForBirthdayImage()
    }
    
    func hiddenForBirthdayLabel() {
        namegiverStackView.hiddenForBirthdayLabel()
    }
    
    func startConffeti() {
        contentView.addSubview(confettiView)
        confettiView.intensity = 0.19
        confettiView.start()
    }
    
    func stopConffeti() {
        confettiView.stop()
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addConstraints() {
        addNamegiverViewConstraints()
        addNamegiverStackViewConstraints()
    }
    
    private func addNamegiverViewConstraints() {
        namegiverView.translatesAutoresizingMaskIntoConstraints = false
        namegiverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        namegiverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        namegiverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        namegiverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func addNamegiverStackViewConstraints() {
        namegiverStackView.translatesAutoresizingMaskIntoConstraints = false
        namegiverStackView.topAnchor.constraint(equalTo: namegiverView.topAnchor).isActive = true
        namegiverStackView.leadingAnchor.constraint(equalTo: namegiverView.leadingAnchor, constant: 10).isActive = true
        namegiverStackView.trailingAnchor.constraint(equalTo: namegiverView.trailingAnchor, constant: -10).isActive = true
        namegiverStackView.bottomAnchor.constraint(equalTo: namegiverView.bottomAnchor).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubview() {
        contentView.addSubview(namegiverView)
        namegiverView.addSubview(namegiverStackView)
    }
    
    private func addSetups() {
        addNamegiverViewSetups()
        addOtherViewSetups()
    }
    
    private func addNamegiverViewSetups() {
        namegiverView.backgroundColor = .white
        namegiverView.layer.cornerRadius = 15
        namegiverView.addShadow()
    }
    
    private func addOtherViewSetups() {
        backgroundColor = Colors.xLight
        contentView.backgroundColor = Colors.xLight
        confettiView.frame = contentView.bounds
    }
}
