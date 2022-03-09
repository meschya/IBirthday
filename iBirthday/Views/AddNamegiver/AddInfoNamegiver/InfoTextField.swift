import UIKit

final class InfoTextField: UIView {
    // MARK: - Properties

    // MARK: Private

    private let stackView: UIStackView = .init()
    private let iconImageView: UIImageView = .init()
    private let infoTextField: UITextField = .init()
    
    var isAutoCorrectionEnabled: Bool = true {
        didSet {
            infoTextField.autocorrectionType = isAutoCorrectionEnabled ? .yes : .no
        }
    }
    
    var text: String {
        get {
            infoTextField.text ?? ""
        }
        set {
            infoTextField.text = newValue
        }
    }

    // MARK: - LIfecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSetups()
        addContraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func configurator(_ image: String, _ placeholder: String, _ type: UIKeyboardType = .default) {
        iconImageView.image = UIImage(named: image)
        infoTextField.placeholder = placeholder
        infoTextField.keyboardType = type
    }
    
    func date(_ image: String, toolbar: UIToolbar, inputView: UIView) {
        iconImageView.image = UIImage(named: image)
        infoTextField.inputAccessoryView = toolbar
        infoTextField.inputView = inputView
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addStackViewConstraints()
        addIconImageViewConstraint()
        addInfoTextFieldConstraints()
    }
    
    private func addStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addIconImageViewConstraint() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addInfoTextFieldConstraints() {
        infoTextField.translatesAutoresizingMaskIntoConstraints = false
        infoTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    // MARK: - Setups

    // MARK: Private

    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(iconImageView, infoTextField)
    }

    private func addSetups() {
        addInfoViewSetups()
        addStackViewSetups()
        addInfoTextFieldSetups()
    }

    private func addInfoViewSetups() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addShadow()
    }
    
    private func addStackViewSetups() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
    }
    
    private func addInfoTextFieldSetups() {
        infoTextField.layer.cornerRadius = 15
        infoTextField.keyboardType = .numberPad
       // infoTextField.addTarget(self, action: #selector(bynTextFieldDidChange(_:)),
                              // for: .editingChanged)
    }
}
